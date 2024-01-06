<?php

namespace App\Filament\Resources\Shield;

use App\Filament\Resources\Shield\UserResource\Pages;
use App\Models\User;
use Filament\Facades\Filament;
use Filament\Resources\Resource;
use Illuminate\Database\Eloquent\Builder;

class UserResource extends Resource
{
    use UserResource\UserForm;
    use UserResource\UserTable;

    protected static ?string $model = User::class;

    protected static ?string $navigationGroup = 'Shield';

    protected static ?string $navigationIcon = 'heroicon-o-users';

    public static function getEloquentQuery(): Builder
    {
        return Filament::getTenant()->users()->getQuery();
    }

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
