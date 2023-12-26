<?php

namespace App\Filament\Resources\UserResource;

use Filament\Forms;
use Filament\Forms\Form;
use Illuminate\Support\Str;

trait UserForm
{
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->autofocus()
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('email')
                    ->email()
                    ->required()
                    ->unique(static::getModel(), 'email', ignoreRecord: auth()->user()?->email)
                    ->maxLength(255),
                Forms\Components\Select::make('role')
                    ->native(false)
                    ->multiple()
                    ->relationship('roles', 'name')
                    ->getOptionLabelFromRecordUsing(function ($record) {
                        return Str::of($record->name)->replace('_', ' ')->title();
                    }),
                Forms\Components\TextInput::make('password')
                    ->password()
                    ->required()
                    ->minLength(8),
            ]);
    }
}
