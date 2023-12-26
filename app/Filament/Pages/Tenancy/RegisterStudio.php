<?php

namespace App\Filament\Pages\Tenancy;

use App\Models\Studio;
use BezhanSalleh\FilamentShield\Support\Utils;
use Filament\Facades\Filament;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Forms\Set;
use Filament\Pages\Tenancy\RegisterTenant;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use LucasDotVin\Soulbscription\Models\Plan;

class RegisterStudio extends RegisterTenant
{
    public static function getLabel(): string
    {
        return 'Register studio';
    }

    public static function canView(): bool
    {
        if (! Filament::auth()->check()) {
            return true;
        }

        return Filament::auth()->user()->studios->count() < 3;
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('name')
                    ->afterStateUpdated(function (Get $get, Set $set, ?string $state) {
                        $set('slug', Str::slug($state));
                    })
                    ->live(onBlur: true)
                    ->required(),
                TextInput::make('slug')
                    ->required(),
            ]);
    }

    protected function handleRegistration(array $data): Studio
    {
        return DB::transaction(function () use (&$data) {
            $business = Studio::create($data);

            $owner = Filament::auth()->user();
            $owner->studios()->attach($business, [
                'owner' => true,
            ]);

            $plan = Plan::whereName('free')->firstOrFail();

            $business->subscribeTo($plan);

            $session_team_id = getPermissionsTeamId();
            // set actual new team_id to package instance
            setPermissionsTeamId($owner);
            // get the admin user and assign roles/permissions on new team model
            $owner->assignRole(Utils::getSuperAdminName());
            // restore session team_id to package instance using temporary value stored above
            setPermissionsTeamId($session_team_id);

            return $business;
        });
    }
}
