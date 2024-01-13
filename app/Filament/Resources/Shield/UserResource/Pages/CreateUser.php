<?php

namespace App\Filament\Resources\Shield\UserResource\Pages;

use App\Filament\Resources\Shield\UserResource;
use App\Models\User;
use Filament\Facades\Filament;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;
use Filament\Support\Exceptions\Halt;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Arr;

class CreateUser extends CreateRecord
{
    protected static string $resource = UserResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        if ($data['password']) {
            $data['password'] = bcrypt($data['password']);
        } else {
            unset($data['password']);
        }

        return $data;
    }

    /**
     * @param  array<string, mixed>  $data
     */
    protected function handleRecordCreation(array $data): User
    {
        $record = $this->getModel()::firstOrCreate(
            Arr::only($data, ['email']),
            Arr::except($data, ['email']),
        );

        if (
            static::getResource()::isScopedToTenant() &&
            ($tenant = Filament::getTenant())
        ) {
            if ($record->wasRecentlyCreated) {
                $record->tenants()->attach($tenant);

                return $record;
            }
            
            if ($record->tenants()->where('owner_id', '!=', Filament::getTenant()->owner_id)->doesntExist()) {
                $record->tenants()->attach($tenant);
            } else {
                Notification::make()
                    ->title('User belongs to another company!')
                    ->danger()
                    ->send();
                
                throw new Halt;
            }
        }

        return $record;
    }
}
