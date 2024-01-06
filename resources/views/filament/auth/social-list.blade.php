@php
    $panel = filament()->getCurrentPanel();
    $panelId = $panel->getId();
    $panelPath = $panel->getPath();
@endphp
<section class='flex flex-col gap-4 filalite-panel'>
    <div class="relative flex items-center">
        <div class="flex-grow border-t border-gray-400"></div>
        <span class="flex-shrink px-4 mx-4 text-gray-400">Or</span>
        <div class="flex-grow border-t border-gray-400"></div>
    </div>
    <div class='flex justify-center p-2 gap-x-4'>
        <a class='flex items-center gap-2 px-4 py-1 transition-all rounded-lg ring-2 ring-slate-700/50 hover:ring-slate-600/70' href='{{ route('auth.social.redirect') }}'>
            <x-icon name="ri-google-fill" class='w-8' />
            <span>Login with Google</span>
        </a>
    </div>
</section>