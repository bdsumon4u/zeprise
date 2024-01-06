<?php

namespace App\Filament\Resources\Shop;

use App\Filament\Resources\Shop\CategoryResource\Pages;
use App\Filament\Resources\Shop\CategoryResource\RelationManagers;
use App\Models\Shop\Category;
use Filament\Forms;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\SpatieMediaLibraryFileUpload;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Support\Services\RelationshipJoiner;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Support\Str;

class CategoryResource extends Resource
{
    protected static ?string $model = Category::class;

    protected static ?string $slug = 'shop/categories';

    protected static ?string $recordTitleAttribute = 'name';

    protected static ?string $navigationGroup = 'Shop';

    protected static ?string $navigationIcon = 'heroicon-o-tag';

    protected static ?string $navigationParentItem = 'Products';

    protected static ?int $navigationSort = 2;

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
                                        ->unique(Category::class, 'slug', ignoreRecord: true),
                                ]),

                            Forms\Components\Select::make('parent_id')
                                ->label('Parent')
                                ->relationship('parent')
                                ->options(static function (Select $component): ?array {
                                    $relationship = Relation::noConstraints(fn () => $component->getRelationship());

                                    $relationshipQuery = app(RelationshipJoiner::class)->prepareQueryForNoConstraints($relationship)->tree();

                                    // modify query

                                    $qualifiedRelatedKeyName = 'categories.id';

                                    return $relationshipQuery
                                        ->get()
                                        ->mapWithKeys(static fn (Category $record) => [
                                            $record->{Str::afterLast($qualifiedRelatedKeyName, '.')} => $component->getOptionLabelFromRecord($record),
                                        ])
                                        ->toArray();
                                })
                                ->searchable()
                                // ->getSearchResultsUsing(function (string $search) {
                                //     dd(Category::tree()->get());
                                //     return Category::tree()->get();
                                // })
                                ->getOptionLabelFromRecordUsing(function (Category $record) {
                                    return $record->name_path;
                                })
                                ->placeholder('Select parent category')
                                ->preload(),

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
                                ->hiddenLabel(),
                        ]),
                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\Placeholder::make('created_at')
                                ->label('Created at')
                                ->content(fn (Category $record): ?string => $record->created_at?->diffForHumans()),

                            Forms\Components\Placeholder::make('updated_at')
                                ->label('Last modified at')
                                ->content(fn (Category $record): ?string => $record->updated_at?->diffForHumans()),
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
                Tables\Columns\TextColumn::make('name')
                    ->label('Name')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('parent.name')
                    ->label('Parent')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\IconColumn::make('is_enabled')
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
                Tables\Actions\EditAction::make(),
            ])
            ->groupedBulkActions([
                Tables\Actions\DeleteBulkAction::make()
                    ->action(function () {
                        Notification::make()
                            ->title('Now, now, don\'t be cheeky, leave some records for others to play with!')
                            ->warning()
                            ->send();
                    }),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            // RelationManagers\ProductsRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCategories::route('/'),
            'create' => Pages\CreateCategory::route('/create'),
            'edit' => Pages\EditCategory::route('/{record}/edit'),
        ];
    }
}
