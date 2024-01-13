<?php

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
        Schema::create('branches', function (Blueprint $table) {
            $table->id();
            $table->foreignId('owner_id')->index();
            $table->string('name');
            $table->string('slug')->index();
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

            $table->unique(['owner_id', 'slug']);
        });

        Schema::create('branch_user', function (Blueprint $table) {
            $table->foreignIdFor(Branch::class)->index();
            $table->foreignIdFor(User::class)->index();
            $table->boolean('owner')->default(false);
            $table->timestamps();

            $table->primary(['branch_id', 'user_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('branch_user');
        Schema::dropIfExists('branches');
    }
};
