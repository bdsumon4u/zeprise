<?php

use App\Models\User;
use Filament\Facades\Filament;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;
use Laravel\Socialite\Two\InvalidStateException;

Route::get('/auth/redirect', function () {
    $referer = request()->headers->get('referer');
    if (! Session::exists('auth.social.intended.url')) {
        Session::put('auth.social.intended.url', $referer);
    }

    return Socialite::driver('google')->redirect();
})->name('auth.social.redirect');

Route::get('/auth/callback', function () {
    $redirectUrl = Session::pull('auth.social.intended.url', Filament::getLoginUrl());

    try {
        /** @var \SocialiteProviders\Manager\OAuth2\User $user */
        $user = Socialite::driver('google')->user();

        Auth::login(User::query()->firstOrCreate([
            'email' => $user->getEmail(),
        ], [
            'name' => $user->getName(),
            'password' => Str::random(10),
        ]));

        return redirect()->to($redirectUrl);
    } catch (InvalidStateException $e) {
        Session::flash('auth.social.error', 'Something went wrong. Please try again.');

        return redirect()->to($redirectUrl);
    } catch (\GuzzleHttp\Exception\ClientException $e) {
        Session::flash('auth.social.error', 'We had a problem contacting the authentication server. Please try again.');

        return redirect()->to($redirectUrl);
    } catch (Exception $e) {
        Session::flash('auth.social.error', 'An unknown error occurred: ' . $e->getMessage() . '. Please try again.');

        return redirect()->to($redirectUrl);
    }
})->name('auth.social.callback');

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
