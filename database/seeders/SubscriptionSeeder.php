<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use LucasDotVin\Soulbscription\Enums\PeriodicityType;
use LucasDotVin\Soulbscription\Models\Feature;
use LucasDotVin\Soulbscription\Models\Plan;

class SubscriptionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $dailyOrder = Feature::create([
            'consumable'       => true,
            'name'             => 'daily-order',
            'periodicity_type' => PeriodicityType::Day,
            'periodicity'      => 1,
        ]);

        $customDomain = Feature::create([
            'consumable' => false,
            'name'       => 'custom-domain',
        ]);


        $free = Plan::create([
            'name'             => 'free',
            'periodicity_type' => null,
            'periodicity'      => null,
        ]);
        $free->features()->attach($dailyOrder, ['charges' => 10]);

        $silver = Plan::create([
            'name'             => 'silver',
            'periodicity_type' => PeriodicityType::Month,
            'periodicity'      => 1,
            'grace_days'       => 7,
        ]);
        $silver->features()->attach($dailyOrder, ['charges' => 50]);
        $silver->features()->attach($customDomain);

        $gold = Plan::create([
            'name'             => 'gold',
            'periodicity_type' => PeriodicityType::Month,
            'periodicity'      => 1,
            'grace_days'       => 7,
        ]);
        $gold->features()->attach($dailyOrder, ['charges' => 100]);
        $gold->features()->attach($customDomain);
    }
}
