<?php

namespace App\Providers\Filament;

use App\Filament\Billing\TenantBillingProvider;
use App\Filament\Pages\Tenancy\EditStudioProfile;
use App\Filament\Pages\Tenancy\RegisterStudio;
use App\Http\Middleware\SyncSpatiePermissionsWithFilamentTenants;
use App\Models\Studio;
use Filament\Facades\Filament;
use Filament\Http\Middleware\Authenticate;
use Filament\Http\Middleware\DisableBladeIconComponents;
use Filament\Http\Middleware\DispatchServingFilamentEvent;
use Filament\Navigation\MenuItem;
use Filament\Pages;
use Filament\Panel;
use Filament\PanelProvider;
use Filament\Support\Colors\Color;
use Filament\Support\Facades\FilamentView;
use Filament\Tables\Table;
use Filament\Widgets;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Session\Middleware\AuthenticateSession;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\Support\Facades\Blade;
use Illuminate\View\Middleware\ShareErrorsFromSession;

class AppPanelProvider extends PanelProvider
{
    public function panel(Panel $panel): Panel
    {
        return $panel
            ->default()
            ->id('app')
            ->path('app')
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
            ->discoverResources(in: app_path('Filament/Resources'), for: 'App\\Filament\\Resources')
            ->discoverPages(in: app_path('Filament/Pages'), for: 'App\\Filament\\Pages')
            ->pages([
                Pages\Dashboard::class,
            ])
            ->discoverWidgets(in: app_path('Filament/Widgets'), for: 'App\\Filament\\Widgets')
            ->widgets([
                Widgets\AccountWidget::class,
                Widgets\FilamentInfoWidget::class,
            ])
            ->plugins([
                \BezhanSalleh\FilamentShield\FilamentShieldPlugin::make(),
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

    public function boot(): void
    {
        Table::$defaultCurrency = 'bdt';
        Table::$defaultDateDisplayFormat = 'd-M-Y';
        Table::$defaultDateTimeDisplayFormat = 'd-M-Y h:i:s A';
        Table::$defaultTimeDisplayFormat = 'h:i:s A';

        Model::resolveRelationUsing(
            ($panel = Filament::getCurrentPanel())->getTenantOwnershipRelationshipName(),
            fn (Model $model): BelongsTo => $model->belongsTo(
                $tenantModel = $panel->getTenantModel(),
                app($tenantModel)->getForeignKey(),
            ),
        );

        FilamentView::registerRenderHook('panels::global-search.before', function () {
            return Blade::render(
                <<<'blade'
                    <x-filament::link
                        href="/pos"
                        icon="heroicon-o-building-storefront"
                    >
                        POS
                    </x-filament::link>
                blade,
            );
        });
    }
}
