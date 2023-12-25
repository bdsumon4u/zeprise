<?php

namespace App\Models;

use Filament\Models\Contracts\HasCurrentTenantLabel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use LucasDotVin\Soulbscription\Models\Concerns\HasSubscriptions;

class Business extends Model implements HasCurrentTenantLabel
{
    use HasFactory;
    use HasSubscriptions;

    public function getCurrentTenantLabel(): string
    {
        return 'Plan: ' . strtoupper($this->subscription->plan->name);
    }

    public function members()
    {
        return $this->belongsToMany(User::class);
    }
}
