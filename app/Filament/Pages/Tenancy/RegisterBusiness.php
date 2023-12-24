<?php

namespace App\Filament\Pages\Tenancy;

use App\Models\Business;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Forms\Set;
use Filament\Pages\Tenancy\RegisterTenant;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class RegisterBusiness extends RegisterTenant
{
    public static function getLabel(): string
    {
        return 'Register business';
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
                    ->readOnly()
                    ->required(),
            ]);
    }

    protected function handleRegistration(array $data): Business
    {
        return DB::transaction(function () use (&$data) {
            $business = Business::create($data);

            $business->members()->attach(auth()->user());

            return $business;
        });
    }
}
