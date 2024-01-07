<?php

namespace App\Models;

use Filament\Facades\Filament;
use Filament\Models\Contracts\HasCurrentTenantLabel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
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
        return $this->belongsToMany(User::class)->withPivot(['owner']);
    }

    public function owner(): User
    {
        return $this->users()->wherePivot('owner', true)->firstOrFail([
            Filament::auth()->user()->getKeyName(),
            $this->getForeignKey(),
        ]);
    }

    public function district(): BelongsTo
    {
        return $this->belongsTo(District::class);
    }

    public function thana(): BelongsTo
    {
        return $this->belongsTo(Thana::class);
    }

    public function brands(): HasMany
    {
        return $this->hasMany(Shop\Brand::class);
    }

    public function categories(): HasMany
    {
        return $this->hasMany(Shop\Category::class);
    }

    public function products(): HasMany
    {
        return $this->hasMany(Shop\Product::class);
    }

    public function customers(): HasMany
    {
        return $this->hasMany(Shop\Customer::class);
    }
}
