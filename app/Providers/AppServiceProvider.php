<?php

namespace App\Providers;

use Filament\Facades\Filament;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Table::$defaultCurrency = 'bdt';
        Table::$defaultDateDisplayFormat = 'd-M-Y';
        Table::$defaultDateTimeDisplayFormat = 'd-M-Y h:i:s A';
        Table::$defaultTimeDisplayFormat = 'h:i:s A';

        Model::unguard();
        Model::preventLazyLoading(! $this->app->environment('production'));
        Model::resolveRelationUsing(
            ($panel = Filament::getCurrentPanel())->getTenantOwnershipRelationshipName(),
            fn (Model $model): BelongsTo => $model->belongsTo(
                $tenantModel = $panel->getTenantModel(),
                app($tenantModel)->getForeignKey(),
            ),
        );
    }
}
