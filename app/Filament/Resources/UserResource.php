<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Models\User;
use Filament\Resources\Resource;

class UserResource extends Resource
{
    use UserResource\UserForm;
    use UserResource\UserTable;

    protected static ?string $model = User::class;

    protected static ?string $navigationGroup = 'Shield';

    protected static ?string $navigationIcon = 'heroicon-o-users';

    protected static bool $isScopedToTenant = false;

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            // 'view' => Pages\ViewUser::route('/{record}'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}
