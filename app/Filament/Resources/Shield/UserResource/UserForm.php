<?php

namespace App\Filament\Resources\Shield\UserResource;

use App\Models\User;
use Filament\Facades\Filament;
use Filament\Forms;
use Filament\Forms\Form;
use Illuminate\Support\Str;
use Spatie\Permission\Models\Role;
use Ysfkaya\FilamentPhoneInput\Forms\PhoneInput;

trait UserForm
{
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make([
                    Forms\Components\Section::make('Personal Information')
                        ->schema([
                            Forms\Components\TextInput::make('name')
                                ->autofocus()
                                ->required()
                                ->maxLength(255)
                                ->columnSpan(['lg' => 2]),
                            Forms\Components\TextInput::make('email')
                                ->email()
                                ->required()
                                ->unique(static::getModel(), 'email', ignoreRecord: auth()->user()?->email)
                                ->maxLength(255),
                            PhoneInput::make('phone')
                                ->disableIpLookUp()
                                ->disallowDropdown()
                                ->defaultCountry('bd')
                                ->initialCountry('bd')
                                ->onlyCountries(['bd'])
                                // ->unique(static::getModel(), 'phone', ignoreRecord: auth()->user()?->phone)
                                ->required(),
                        ])
                        ->columns(['lg' => 2]),
                    Forms\Components\Section::make('Change Password')
                        ->visibleOn('edit')
                        ->schema([
                            Forms\Components\TextInput::make('current_password')
                                ->password()
                                ->currentPassword()
                                ->dehydrated(false),

                            Forms\Components\TextInput::make('password')
                                ->label('New password')
                                ->password()
                                ->confirmed()
                                ->minLength(8),

                            Forms\Components\TextInput::make('password_confirmation')
                                ->password()
                                ->dehydrated(false),
                        ])
                        ->columns(3),
                ])
                ->columnSpan(['lg' => 2]),
                Forms\Components\Group::make([
                    Forms\Components\Section::make('Authentication / Authorization')
                        ->schema([
                            Forms\Components\Select::make('roles')
                                ->relationship('roles', 'name')
                                ->getOptionLabelFromRecordUsing(fn (Role $record) => Str::headline($record->name))
                                ->saveRelationshipsUsing(fn (User $user, $state) => $user->syncRoles(
                                    Role::query(fn ($query) => $query->whereBelongsTo(
                                        ($owner = Filament::getTenant()->owner())->orWhereNull($owner->getForeignKey())
                                    ))->findOrFail($state)
                                ))
                                ->multiple()
                                ->preload()
                                ->searchable()
                                ->native(false),
                            Forms\Components\TextInput::make('password')
                                ->password()
                                ->required()
                                ->minLength(8)
                                ->visibleOn('create'),
                        ]),
                ])
                ->columnSpan(['lg' => 1]),
            ])
            ->columns(3);
    }
}
