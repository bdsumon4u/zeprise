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
                Forms\Components\Select::make('roles')
                    ->relationship('roles', 'name')
                    ->multiple()
                    ->preload()
                    ->searchable()
                    ->native(false)
                    ->getOptionLabelFromRecordUsing(function ($record) {
                        return Str::of($record->name)->replace('_', ' ')->title();
                    }),
                Forms\Components\TextInput::make('password')
                    ->required(function ($component) {
                        return $component->getContainer()->getOperation() === 'create';
                    })
                    ->password()
                    ->minLength(8),
            ]);
    }
}
