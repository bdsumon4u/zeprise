<?php

namespace App\Models;

use Filament\Facades\Filament;
use Filament\Models\Contracts\HasCurrentTenantLabel;
use Filament\Models\Contracts\HasName;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use LucasDotVin\Soulbscription\Models\Concerns\HasSubscriptions;

class Branch extends Model implements HasName, HasCurrentTenantLabel
{
    use HasFactory;
    use HasSubscriptions;

    /**
     * Retrieve the model for a bound value.
     *
     * @param  mixed  $value
     * @param  string|null  $field
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function resolveRouteBinding($value, $field = null)
    {
        /** @var User */
        $owner = Filament::auth()->user();

        return $owner->tenants()->where($field, $value)->first();
    }

    public function getFilamentName(): string
    {
        return $this->name;
        return $this->name . ' # ' . $this->owner->name;
    }

    public function getCurrentTenantLabel(): string
    {
        return $this->owner->name;
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

    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class, 'owner_id');
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

    public function attributes(): HasMany
    {
        return $this->hasMany(Attribute::class);
    }

    public function options(): HasMany
    {
        return $this->hasMany(Option::class);
    }
}
