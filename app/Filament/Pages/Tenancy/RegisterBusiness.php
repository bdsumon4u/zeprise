<?php

namespace App\Filament\Pages\Tenancy;

use App\Models\Admin;
use App\Models\Business;
use Filament\Facades\Filament;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Forms\Set;
use Filament\Pages\Tenancy\RegisterTenant;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use LucasDotVin\Soulbscription\Models\Plan;

class RegisterBusiness extends RegisterTenant
{
    public static function getLabel(): string
    {
        return 'Register business';
    }

    public static function canView(): bool
    {
        if (! Filament::auth()->check()) return true;

        return Filament::auth()->user()->businesses->count() < 3;
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('name')
                    ->afterStateUpdated(function (Get $get, Set $set, ?string $state) {
                        $set('slug', Str::slug($state));
                    })
                    ->reactive()
                    ->debounce()
                    ->required(),
                TextInput::make('slug')
                    ->readOnly()
                    ->required(),
            ]);
    }

    protected function handleRegistration(array $data): Business
    {
        return DB::transaction(function () use (&$data) {
            $admin = (fn () : Admin => auth()->user())();
            $business = $admin->businesses()->create($data);

            $plan = Plan::whereName('free')->firstOrFail();

            $business->subscribeTo($plan);

            $session_team_id = getPermissionsTeamId();
            // set actual new team_id to package instance
            setPermissionsTeamId($business);
            // get the admin user and assign roles/permissions on new team model
            $admin->assignRole('Super Admin');
            // restore session team_id to package instance using temporary value stored above
            setPermissionsTeamId($session_team_id);

            return $business;
        });
    }
}
