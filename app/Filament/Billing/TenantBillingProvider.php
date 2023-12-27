<?php

namespace App\Filament\Billing;

use App\Http\Middleware\RedirectIfUserNotSubscribed;
use Closure;
use Filament\Billing\Providers\Contracts\Provider;
use Illuminate\Http\RedirectResponse;

class TenantBillingProvider implements Provider
{
    public function getRouteAction():  string | Closure | array
    {
        return function (): RedirectResponse {
            return redirect('https://billing.example.com');
        };
    }

    public function getSubscribedMiddleware(): string
    {
        return RedirectIfUserNotSubscribed::class;
    }
}
