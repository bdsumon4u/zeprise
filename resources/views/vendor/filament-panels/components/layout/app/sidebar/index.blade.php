@props([
    'navigation',
])

<aside class="hidden md:flex md:shrink-0">
    <div class="flex">
        <x-filament-panels::layout.app.sidebar.primary />

        <div
            class="w-56 bg-white dark:bg-secondary-900 border-r border-transparent md:border-secondary-200 md:dark:border-secondary-700">
            <x-filament-panels::layout.app.sidebar.secondary :navigation="$navigation" />
        </div>
    </div>
</aside>
