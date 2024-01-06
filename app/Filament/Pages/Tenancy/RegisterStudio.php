<?php

namespace App\Filament\Pages\Tenancy;

use App\Models\District;
use App\Models\Studio;
use App\Models\Thana;
use BezhanSalleh\FilamentShield\Support\Utils;
use Filament\Actions\Action;
use Filament\Actions\ActionGroup;
use Filament\Facades\Filament;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\MarkdownEditor;
use Filament\Forms\Components\RichEditor;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Wizard;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Forms\Set;
use Filament\Pages\Concerns;
use Filament\Pages\Concerns\InteractsWithFormActions;
use Filament\Pages\SimplePage;
use Filament\Panel;
use Filament\Support\Exceptions\Halt;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Contracts\Support\Htmlable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\HtmlString;
use Illuminate\Support\Str;
use LucasDotVin\Soulbscription\Models\Plan;
use Ysfkaya\FilamentPhoneInput\Forms\PhoneInput;

use function Filament\authorize;

/**
 * @property Form $form
 */
class RegisterStudio extends SimplePage
{
    use Concerns\HasRoutes;
    use InteractsWithFormActions;

    protected ?string $maxWidth = '3xl';

    /**
     * @var view-string
     */
    protected static string $view = 'filament-panels::pages.tenancy.register-tenant';

    /**
     * @var array<string, mixed> | null
     */
    public ?array $data = [];

    public ?Model $tenant = null;

    public static function getLabel(): string
    {
        return 'Register studio';
    }

    public static function routes(Panel $panel): void
    {
        $slug = static::getSlug();

        Route::get("/{$slug}", static::class)
            ->middleware(static::getRouteMiddleware($panel))
            ->withoutMiddleware(static::getWithoutRouteMiddleware($panel))
            ->name('registration');
    }

    /**
     * @return string | array<string>
     */
    public static function getRouteMiddleware(Panel $panel): string | array
    {
        return [
            ...(static::isEmailVerificationRequired($panel) ? [static::getEmailVerifiedMiddleware($panel)] : []),
            ...Arr::wrap(static::$routeMiddleware),
        ];
    }

    public function mount(): void
    {
        abort_unless(static::canView(), 404);

        $this->form->fill();
    }

    /**
     * @param  array<string, mixed>  $data
     * @return array<string, mixed>
     */
    protected function mutateFormDataBeforeRegister(array $data): array
    {
        return $data;
    }

    public function register(): void
    {
        try {
            $this->callHook('beforeValidate');

            $data = $this->form->getState();

            $this->callHook('afterValidate');

            $data = $this->mutateFormDataBeforeRegister($data);

            $this->callHook('beforeRegister');

            $this->tenant = $this->handleRegistration($data);

            $this->form->model($this->tenant)->saveRelationships();

            $this->callHook('afterRegister');
        } catch (Halt $exception) {
            return;
        }

        if ($redirectUrl = $this->getRedirectUrl()) {
            $this->redirect($redirectUrl);
        }
    }

    protected function handleRegistration(array $data): Studio
    {
        return DB::transaction(function () use (&$data) {
            $business = Studio::create($data);

            $owner = Filament::auth()->user();
            $owner->studios()->attach($business, [
                'owner' => true,
            ]);

            $plan = Plan::whereName('free')->firstOrFail();

            $business->subscribeTo($plan);

            $session_team_id = getPermissionsTeamId();
            // set actual new team_id to package instance
            setPermissionsTeamId($owner);
            // get the admin user and assign roles/permissions on new team model
            $owner->assignRole(Utils::getSuperAdminName());
            // restore session team_id to package instance using temporary value stored above
            setPermissionsTeamId($session_team_id);

            return $business;
        });
    }

    protected function getRedirectUrl(): ?string
    {
        return Filament::getUrl($this->tenant);
    }

    public function form(Form $form): Form
    {
        return $form->schema([
            Wizard::make([
                Wizard\Step::make('Studio Information')->schema([
                    TextInput::make('name')
                        ->afterStateUpdated(function (Get $get, Set $set, ?string $state) {
                            $set('slug', Str::slug($state));
                        })
                        ->live(onBlur: true)
                        ->required(),
                    TextInput::make('slug')
                        ->required(),
                    TextInput::make('email')
                        ->email()
                        ->required(),
                    PhoneInput::make('phone')
                        ->disableIpLookUp()
                        ->disallowDropdown()
                        ->defaultCountry('bd')
                        ->initialCountry('bd')
                        ->onlyCountries(['bd'])
                        ->required(),
                    MarkdownEditor::make('about')
                        ->columnSpan(2)
                        ->required(),
                ])->columns(2),
                Wizard\Step::make('Address Information')->schema([
                    Select::make('district_id')
                        ->relationship('district', titleAttribute: 'name')
                        ->searchable()
                        ->preload()
                        ->required(),
                    Select::make('thana_id')
                        ->relationship('thana', 'name', function (Get $get, $query) {
                            $query->where('district_id', $get('district_id'));
                        })
                        ->searchable()
                        ->required(),
                    TextInput::make('street_address')
                        ->columnSpan(2)
                        ->required(),
                ])->columns(2),
                Wizard\Step::make('Social Information')->schema([
                    TextInput::make('facebook')
                        ->prefixIcon('ri-facebook-fill')
                        ->url(),
                    TextInput::make('instagram')
                        ->prefixIcon('ri-instagram-fill')
                        ->url(),
                    TextInput::make('tiktok')
                        ->prefixIcon('ri-tiktok-fill')
                        ->url(),
                    TextInput::make('youtube')
                        ->prefixIcon('ri-youtube-fill')
                        ->url(),
                ])->columns(2),
            ])
            ->submitAction(new HtmlString(Blade::render(<<<BLADE
                <x-filament::button
                    type="submit"
                >
                    Submit
                </x-filament::button>
            BLADE))),
        ]);
    }

    /**
     * @return array<int | string, string | Form>
     */
    protected function getForms(): array
    {
        return [
            'form' => $this->form(
                $this->makeForm()
                    ->model($this->getModel())
                    ->statePath('data'),
            ),
        ];
    }

    public function getModel(): string
    {
        return Filament::getTenantModel();
    }

    public function getTitle(): string | Htmlable
    {
        return static::getLabel();
    }

    public static function getSlug(): string
    {
        return static::$slug ?? 'new';
    }

    public function hasLogo(): bool
    {
        return true;
    }

    /**
     * @return array<Action | ActionGroup>
     */
    protected function getFormActions(): array
    {
        return [
            // $this->getRegisterFormAction(),
        ];
    }

    public function getRegisterFormAction(): Action
    {
        return Action::make('register')
            ->label(static::getLabel())
            ->submit('register');
    }

    protected function hasFullWidthFormActions(): bool
    {
        return true;
    }

    public static function canView(): bool
    {

        if (!Filament::auth()->check()) {
            return true;
        }

        return Filament::auth()->user()->studios->count() < 3;

        try {
            return authorize('create', Filament::getTenantModel())->allowed();
        } catch (AuthorizationException $exception) {
            return $exception->toResponse()->allowed();
        }
    }
}
