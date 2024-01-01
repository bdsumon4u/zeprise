@php
    use Filament\Support\Enums\MaxWidth;

    $navigation = filament()->getNavigation();
@endphp

<x-filament-panels::layout.base :livewire="$livewire">

    <div class="h-screen flex overflow-hidden" x-data="{ sidebarOpen: false, modalDemo: false }" @keydown.window.escape="sidebarOpen = false">
        <x-filament-panels::layout.app.sidebar :navigation="$navigation" />

        <x-filament-panels::layout.app.sidebar.mobile :navigation="$navigation" />

        <div class="flex flex-col w-0 flex-1 overflow-hidden overflow-y-auto">
            <x-filament-panels::layout.app.header />

            <main class="flex-1 relative z-0 py-3 lg:py-6">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 min-h-(screen-content) 2xl:px-8 2xl:max-w-8xl">
                    {{ $slot }}
                </div>
            </main>
        </div>

        {{-- <x-filament-panels::wip /> --}}
    </div>

</x-filament-panels::layout.base>
