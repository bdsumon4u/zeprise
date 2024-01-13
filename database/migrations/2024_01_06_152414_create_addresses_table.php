<?php

use App\Models\Shop\Customer;
use App\Models\District;
use App\Models\Branch;
use App\Models\Thana;
use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('addresses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('owner_id')->index();
            $table->foreignIdFor(Customer::class)->index();
            $table->foreignIdFor(District::class);
            $table->foreignIdFor(Thana::class);
            $table->string('street_address');
            $table->string('name');
            $table->string('phone');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('addresses');
    }
};
