<?php

use App\Models\Admin;
use App\Models\Business;
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
        Schema::create('businesses', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Admin::class);
            $table->string('name');
            $table->string('slug')->unique()->index();
            $table->timestamps();
        });

        Schema::create('business_user', function (Blueprint $table) {
            $table->foreignIdFor(Business::class);
            $table->foreignIdFor(User::class);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('business_user');
        Schema::dropIfExists('businesses');
    }
};
