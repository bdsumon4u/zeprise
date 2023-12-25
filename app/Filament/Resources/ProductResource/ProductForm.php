<?php

namespace App\Filament\Resources\ProductResource;

use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
trait ProductForm
{
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('name')
                    ->unique(onTenant: true)
                    ->required(),
            ]);
    }
}