<?php

namespace App\Filament\Resources\UserResource;

use Filament\Facades\Filament;
use Filament\Forms;
use Filament\Forms\Form;
use Illuminate\Support\Str;
use Spatie\Permission\Models\Role;

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
                    ->options(fn () => Role::query()
                        ->whereBelongsTo(Filament::getTenant())
                        ->orWhereNull(config('permission.column_names.team_foreign_key'))
                        ->get()
                        ->mapWithKeys(fn ($role) => [$role->name => $role->name])
                    )
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
