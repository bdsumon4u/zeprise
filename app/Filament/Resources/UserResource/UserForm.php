<?php

namespace App\Filament\Resources\UserResource;

use Filament\Forms\Form;

trait UserForm
{
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }
}
