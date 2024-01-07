<?php

namespace App\Filament\Resources\Shop\CustomerResource\Pages;

use App\Filament\Resources\Shop\CustomerResource;
use App\Models\Shop\Customer;
use Filament\Actions;
use Filament\Facades\Filament;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class CreateCustomer extends CreateRecord
{
    protected static string $resource = CustomerResource::class;

    /**
     * @param  array<string, mixed>  $data
     * @return array<string, mixed>
     */
    protected function mutateFormDataBeforeCreate(array $data): array
    {
        if (! $data['has_password']) {
            $data['password'] = Str::random(10);
        }

        return $data;
    }

    /**
     * @param  array<string, mixed>  $data
     */
    protected function handleRecordCreation(array $data): Customer
    {
        return DB::transaction(function () use (&$data) {
            $customer = Filament::getTenant()->customers()->create(
                Arr::only($data, ['name', 'phone', 'password'])
            );

            if ($data['has_address']) {
                $record = $customer->addresses()->make(Arr::only($data, [
                    'district_id', 'thana_id', 'name', 'phone', 'street_address',
                ]));

                $this->associateRecordWithTenant($record, Filament::getTenant());
            }

            return $customer;
        });
    }
}
