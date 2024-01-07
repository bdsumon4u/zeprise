<?php

namespace App\Filament\Resources\Shop;

use App\Filament\Resources\Shop\CustomerResource\Pages;
use App\Filament\Resources\Shop\CustomerResource\RelationManagers;
use App\Models\District;
use App\Models\Thana;
use App\Models\Shop\Customer;
use Closure;
use Filament\Facades\Filament;
use Filament\Forms;
use Filament\Forms\Components\Select;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\Facades\Hash;
use Squire\Models\Country;
use Ysfkaya\FilamentPhoneInput\Forms\PhoneInput;

class CustomerResource extends Resource
{
    protected static ?string $model = Customer::class;

    protected static ?string $slug = 'shop/customers';

    protected static ?string $recordTitleAttribute = 'name';

    protected static ?string $navigationGroup = 'Shop';

    protected static ?string $navigationIcon = 'heroicon-o-user-group';

    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Profile overview')
                    ->description('Use a personal information. This may or may not match with receiver\'s information.')
                    ->aside()
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->maxLength(255)
                            ->required(),
                        PhoneInput::make('phone')
                            ->disableIpLookUp()
                            ->disallowDropdown()
                            ->defaultCountry('bd')
                            ->initialCountry('bd')
                            ->onlyCountries(['bd'])
                            ->unique(
                                ignoreRecord: true,
                                modifyRuleUsing: fn ($rule) => $rule->where(function ($query) {
                                    $foreignKey = ($tenant = Filament::getTenant())->getForeignKey();

                                    return $query->where($foreignKey, $tenant->getKey())->orWhereNull($foreignKey);
                                })
                            )
                            ->required(),
                        Forms\Components\Grid::make()
                            ->visibleOn('create')
                            ->schema([
                                Forms\Components\Toggle::make('has_address')
                                    ->default(mt_rand(0, 1))
                                    ->live(),
                                Forms\Components\Toggle::make('has_password')
                                    ->default(mt_rand(0, 1))
                                    ->live(),
                            ]),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Address')
                    ->description('The primary address of this customer. This address will be defined as default shipping address.')
                    ->visibleOn('create')
                    ->aside()
                    ->schema([
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
                    ])
                    ->columns(['lg' => 2])
                    ->visible(fn (Get $get) => $get('has_address')),

                Forms\Components\Section::make('Security')
                    ->description('Enter a random password that this user will use to login to his account.')
                    ->visibleOn('create')
                    ->aside()
                    ->schema([
                        Forms\Components\TextInput::make('password')
                            ->password()
                            ->confirmed()
                            ->required()
                            ->minLength(8),

                        Forms\Components\TextInput::make('password_confirmation')
                            ->password()
                            ->required()
                            ->dehydrated(false),
                    ])
                    ->columns(2)
                    ->visible(fn (Get $get) => $get('has_password')),

                Forms\Components\Section::make('Change password')
                    ->description('You may optionally change the password.')
                    ->visibleOn('edit')
                    ->aside()
                    ->schema([
                        Forms\Components\TextInput::make('current_password')
                            ->password()
                            ->rules([
                                function () use (&$form) {
                                    $record = $form->getRecord();

                                    return function (string $attribute, $value, Closure $fail) use (&$record) {
                                        Hash::check($value, $record->password) || $fail('The :attribute is invalid.');
                                    };
                                },
                            ])
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
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(isIndividual: true)
                    ->sortable(),
                Tables\Columns\TextColumn::make('email')
                    ->label('Email address')
                    ->searchable(isIndividual: true, isGlobal: false)
                    ->sortable(),
                Tables\Columns\TextColumn::make('phone')
                    ->searchable()
                    ->sortable(),
            ])
            ->filters([
                // Tables\Filters\TrashedFilter::make(),
            ])
            ->actions([
                Tables\Actions\DeleteAction::make(),
            ])
            ->groupedBulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->with('addresses')->withoutGlobalScope(SoftDeletingScope::class);
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\AddressesRelationManager::class,
            // RelationManagers\PaymentsRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCustomers::route('/'),
            'create' => Pages\CreateCustomer::route('/create'),
            'edit' => Pages\EditCustomer::route('/{record}/edit'),
        ];
    }

    public static function getGloballySearchableAttributes(): array
    {
        return ['name', 'email', 'phone'];
    }
}
