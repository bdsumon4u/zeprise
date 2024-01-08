<?php

namespace App\Models;

use App\Models\Shop\Product;
use Illuminate\Database\Eloquent\Casts\Attribute as AttributeCast;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AttributeOptionProduct extends Model
{
    use HasFactory;

    protected function value(): AttributeCast
    {
        return AttributeCast::make(
            get: fn () => $this->custom_value ?? $this->option?->value,
        );
    }

    public function attribute(): BelongsTo
    {
        return $this->belongsTo(Attribute::class);
    }

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    public function option(): BelongsTo
    {
        return $this->belongsTo(Option::class);
    }
}
