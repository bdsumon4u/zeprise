<?php

use App\Models\District;
use App\Models\Studio;
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
        Schema::create('studios', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug')->unique()->index();
            $table->string('email')->unique();
            $table->string('phone')->unique();
            $table->longText('about');
            $table->foreignIdFor(District::class);
            $table->foreignIdFor(Thana::class);
            $table->string('street_address');
            $table->string('facebook')->nullable();
            $table->string('instagram')->nullable();
            $table->string('tiktok')->nullable();
            $table->string('youtube')->nullable();
            $table->timestamps();
        });

        Schema::create('studio_user', function (Blueprint $table) {
            $table->foreignIdFor(Studio::class)->index();
            $table->foreignIdFor(User::class)->index();
            $table->boolean('owner')->default(false);
            $table->timestamps();

            $table->primary(['studio_id', 'user_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('studio_user');
        Schema::dropIfExists('studios');
    }
};
