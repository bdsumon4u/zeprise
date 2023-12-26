<?php

namespace App\Models;

use Filament\Models\Contracts\HasCurrentTenantLabel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use LucasDotVin\Soulbscription\Models\Concerns\HasSubscriptions;

class Studio extends Model implements HasCurrentTenantLabel
{
    use HasFactory;
    use HasSubscriptions;

    public function getCurrentTenantLabel(): string
    {
        return 'Plan: '.strtoupper($this->subscription->plan->name);
    }

    public function roles(): HasMany
    {
        return $this->hasMany(config('permission.models.role'));
    }

    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class);
    }

    public function products()
    {
        return $this->hasMany(Product::class);
    }
}
