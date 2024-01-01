<?php

namespace App\Providers\Filament;

use App\Filament\Pages\Tenancy\EditStudioProfile;
use App\Filament\Pages\Tenancy\RegisterStudio;
use App\Http\Middleware\SyncSpatiePermissionsWithFilamentTenants;
use App\Models\Studio;
use Filament\Http\Middleware\Authenticate;
use Filament\Http\Middleware\DisableBladeIconComponents;
use Filament\Http\Middleware\DispatchServingFilamentEvent;
use Filament\Pages;
use Filament\Panel;
use Filament\PanelProvider;
use Filament\Support\Colors\Color;
use Filament\Widgets;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Session\Middleware\AuthenticateSession;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\View\Middleware\ShareErrorsFromSession;

class PosPanelProvider extends PanelProvider
{
    public function panel(Panel $panel): Panel
    {
        return $panel
            ->id('pos')
            ->domain('pos.ebiz.studio')
            ->login()
            ->registration()
            ->passwordReset()
            ->emailVerification()
            ->profile()
            ->colors([
                'primary' => Color::Rose,
            ])
            ->font('Poppins')
            ->databaseNotifications()
            ->sidebarCollapsibleOnDesktop()
            ->sidebarWidth('18rem')
            ->discoverResources(in: app_path('Filament/Pos/Resources'), for: 'App\\Filament\\Pos\\Resources')
            ->discoverPages(in: app_path('Filament/Pos/Pages'), for: 'App\\Filament\\Pos\\Pages')
            ->pages([
                Pages\Dashboard::class,
            ])
            ->discoverWidgets(in: app_path('Filament/Pos/Widgets'), for: 'App\\Filament\\Pos\\Widgets')
            ->widgets([
                Widgets\AccountWidget::class,
                Widgets\FilamentInfoWidget::class,
            ])
            ->middleware([
                EncryptCookies::class,
                AddQueuedCookiesToResponse::class,
                StartSession::class,
                AuthenticateSession::class,
                ShareErrorsFromSession::class,
                VerifyCsrfToken::class,
                SubstituteBindings::class,
                DisableBladeIconComponents::class,
                DispatchServingFilamentEvent::class,
            ])
            ->authMiddleware([
                Authenticate::class,
            ])
            ->tenantMiddleware([
                SyncSpatiePermissionsWithFilamentTenants::class,
            ], isPersistent: true)
            ->tenant(Studio::class, slugAttribute: 'slug')
            ->tenantRegistration(RegisterStudio::class)
            // ->requiresTenantSubscription()
            // ->tenantBillingProvider(new TenantBillingProvider())
            ->tenantProfile(EditStudioProfile::class)
            ->tenantMenuItems([
                // 'register' => MenuItem::make()->label('Register new team'),
                // 'profile' => MenuItem::make()->label('Edit team profile'),
                // 'billing' => MenuItem::make()->label('Manage subscription'),
                // MenuItem::make()
                //     ->label('Settings')
                //     ->url(fn (): string => '')
                //     ->icon('heroicon-m-cog-8-tooth')
                //     ->visible(fn (): bool => true),
                // ...
            ])
            ->viteTheme('resources/css/filament/app/theme.css')
            ->spa();
    }
}
