<?php

namespace App\Filament\Resources\Shop\CustomerResource\RelationManagers;

use App\Models\District;
use App\Models\Thana;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Ysfkaya\FilamentPhoneInput\Forms\PhoneInput;

class AddressesRelationManager extends RelationManager
{
    protected static string $relationship = 'addresses';

    protected static ?string $recordTitleAttribute = 'street_address';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->default($this->getOwnerRecord()->name)
                    ->required(),
                PhoneInput::make('phone')
                    ->default($this->getOwnerRecord()->phone)
                    ->disableIpLookUp()
                    ->disallowDropdown()
                    ->defaultCountry('bd')
                    ->initialCountry('bd')
                    ->onlyCountries(['bd'])
                    ->required(),
                Forms\Components\Select::make('district_id')
                    ->label('District')
                    ->options(static fn () => District::get(['id', 'name'])->pluck('name', 'id'))
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\Select::make('thana_id')
                    ->label('Thana')
                    ->options(function (Get $get) {
                        if (! $get('district_id')) return [];

                        return Thana::query()
                            ->where('district_id', $get('district_id'))
                            ->get(['id', 'district_id', 'name'])
                            ->pluck('name', 'id');
                    })
                    ->searchable()
                    ->required(),
                Forms\Components\TextInput::make('street_address')
                    ->columnSpan(['lg' => 2])
                    ->required(),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name'),
                Tables\Columns\TextColumn::make('phone'),
                Tables\Columns\TextColumn::make('district.name'),
                Tables\Columns\TextColumn::make('thana.name'),
                Tables\Columns\TextColumn::make('street_address'),
            ])
            ->filters([
                //
            ])
            ->headerActions([
                // Tables\Actions\AttachAction::make(),
                Tables\Actions\CreateAction::make(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                // Tables\Actions\DetachAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->groupedBulkActions([
                // Tables\Actions\DetachBulkAction::make(),
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }
}
