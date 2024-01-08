<?php

namespace App\Models;

use App\Models\Option;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Attribute extends Model
{
    use HasFactory;

    public function getTypeFormattedAttribute(): string
    {
        return static::typesFields()[$this->type];
    }

    public static function typesFields(): array
    {
        return [
            'text' => 'Text field',
            'richtext' => 'Rich text',
            'number' => 'Number',
            'select' => 'Select',
            'radio' => 'Radio',
            'checkbox' => 'Checkbox',
            'colorpicker' => 'Color picker',
            'datepicker' => 'Date picker',
        ];
    }

    public static function fieldsWithOptions(): array
    {
        return [
            'select',
            'checkbox',
            'colorpicker',
            'radio',
        ];
    }

    public function hasMultipleOptions(): bool
    {
        return in_array($this->type, ['checkbox', 'colorpicker']);
    }

    public function hasTextOption(): bool
    {
        return in_array($this->type, ['text', 'number', 'richtext', 'datepicker']);
    }

    public function hasSingleOption(): bool
    {
        return in_array($this->type, ['radio', 'select']);
    }

    public function scopeEnabled(Builder $query): Builder
    {
        return $query->where('is_enabled', true);
    }

    public function scopeFilterable(Builder $query): Builder
    {
        return $query->where('is_filterable', true);
    }

    public function scopeSearchable(Builder $query): Builder
    {
        return $query->where('is_searchable', true);
    }

    public function options(): HasMany
    {
        return $this->hasMany(Option::class);
    }
}
