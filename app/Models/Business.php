<?php

namespace App\Models;

use Filament\Models\Contracts\HasCurrentTenantLabel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use LucasDotVin\Soulbscription\Models\Concerns\HasSubscriptions;
use Spatie\Permission\Traits\HasRoles;

class Business extends Model implements HasCurrentTenantLabel
{
    use HasFactory;
    use HasSubscriptions;
    use HasRoles;

    public function getCurrentTenantLabel(): string
    {
        return 'Plan: ' . strtoupper($this->subscription->plan->name);
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
