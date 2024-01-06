<?php

namespace Database\Seeders;

use App\Models\District;
use App\Models\Thana;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Thana::truncate();
        District::truncate();
        DB::transaction(function () {
            collect(json_decode(file_get_contents(__DIR__ . '/cities.json'), true))
                ->each(
                    fn ($thanas, $district) => District::create(['name' => $district])
                        ->thanas()->createMany($thanas)
                );
        });
    }
}
