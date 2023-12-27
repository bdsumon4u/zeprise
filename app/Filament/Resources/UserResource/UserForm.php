<?php

namespace App\Filament\Resources\UserResource;

use App\Models\User;
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
                    ->required(fn (string $operation): bool => $operation === 'create')
                    ->password()
                    ->minLength(8),
            ]);
    }
}
