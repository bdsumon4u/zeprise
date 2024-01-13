<?php

namespace App\Filament\Resources\Shop;

use App\Filament\Resources\Shop\BrandResource\Pages;
use App\Filament\Resources\Shop\BrandResource\RelationManagers;
use App\Models\Shop\Brand;
use Filament\Forms;
use Filament\Forms\Components\SpatieMediaLibraryFileUpload;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\SpatieMediaLibraryImageColumn;
use Filament\Tables\Table;
use Illuminate\Support\Str;

class BrandResource extends Resource
{
    protected static ?string $model = Brand::class;

    protected static ?string $slug = 'shop/brands';

    protected static ?string $recordTitleAttribute = 'name';

    protected static ?string $navigationGroup = 'Shop';

    protected static ?string $navigationIcon = 'heroicon-o-bookmark-square';

    protected static ?string $navigationParentItem = 'Products';

    protected static ?int $navigationSort = 1;

    protected static bool $isScopedToTenant = false;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make([
                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\Grid::make()
                                ->schema([
                                    Forms\Components\TextInput::make('name')
                                        ->required()
                                        ->maxLength(255)
                                        ->live(onBlur: true)
                                        ->afterStateUpdated(fn (string $operation, $state, Forms\Set $set) => $operation === 'create' ? $set('slug', Str::slug($state)) : null),

                                    Forms\Components\TextInput::make('slug')
                                        ->disabled()
                                        ->dehydrated()
                                        ->required()
                                        ->maxLength(255)
                                        ->unique(Brand::class, 'slug', ignoreRecord: true),
                                ]),

                            Forms\Components\Toggle::make('is_enabled')
                                ->label('Visible to customers.')
                                ->default(true),

                            Forms\Components\MarkdownEditor::make('description')
                                ->label('Description'),
                        ]),
                ])
                ->columnSpan(['lg' => 2]),
                Forms\Components\Group::make([
                    Forms\Components\Section::make('Thumbnail')
                        ->schema([
                            SpatieMediaLibraryFileUpload::make('thumbnail')
                                ->hiddenLabel()
                                ->image(),
                        ]),
                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\Placeholder::make('created_at')
                                ->label('Created at')
                                ->content(fn (Brand $record): ?string => $record->created_at?->diffForHumans()),

                            Forms\Components\Placeholder::make('updated_at')
                                ->label('Last modified at')
                                ->content(fn (Brand $record): ?string => $record->updated_at?->diffForHumans()),
                        ])
                        ->hiddenOn('create'),
                ]),
            ])
            ->columns(3);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                SpatieMediaLibraryImageColumn::make('thumbnail')
                    ->label('')
                    ->square(),
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('slug')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\ToggleColumn::make('is_enabled')
                    ->label('Visibility')
                    ->sortable(),
                Tables\Columns\TextColumn::make('updated_at')
                    ->label('Updated Date')
                    ->date()
                    ->sortable(),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\DeleteAction::make(),
            ])
            ->groupedBulkActions([
                Tables\Actions\DeleteBulkAction::make()
                    ->action(function () {
                        Notification::make()
                            ->title('Now, now, don\'t be cheeky, leave some records for others to play with!')
                            ->warning()
                            ->send();
                    }),
                Tables\Actions\BulkAction::make('Make visible')
                    ->icon('heroicon-o-check-circle')
                    ->color('success')
                    ->action(fn ($records) => $records->each->update(['is_enabled' => true])),
                Tables\Actions\BulkAction::make('Disable')
                    ->icon('heroicon-o-x-circle')
                    ->action(fn ($records) => $records->each->update(['is_enabled' => false])),
            ])
            ->defaultSort('position')
            ->reorderable('position');
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\ProductsRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListBrands::route('/'),
            'create' => Pages\CreateBrand::route('/create'),
            'edit' => Pages\EditBrand::route('/{record}/edit'),
        ];
    }
}
