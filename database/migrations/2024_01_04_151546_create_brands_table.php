<?php

use App\Models\Branch;
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
        Schema::create('brands', function (Blueprint $table) {
            $table->id();
            $table->foreignId('owner_id')->index();
            $table->string('name');
            $table->string('slug');
            $table->longText('description')->nullable();
            $table->unsignedSmallInteger('position')->default(0);
            $table->boolean('is_enabled')->default(true);
            $table->boolean('is_searchable')->default(true);
            $table->string('seo_title', 60)->nullable();
            $table->string('seo_description', 160)->nullable();
            $table->timestamps();

            $table->unique(['owner_id', 'name']);
            $table->unique(['owner_id', 'slug']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('brands');
    }
};
