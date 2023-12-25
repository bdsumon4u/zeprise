<?php

namespace App\Filament\Resources\ProductResource;

use Filament\Facades\Filament;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Illuminate\Validation\Rules\Unique;

trait ProductForm
{
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('name')
                    ->unique(modifyRuleUsing: function (Unique $rule) {
                        return $rule->where('business_id', Filament::getTenant()->id);
                    })
                    ->required(),
            ]);
    }
}