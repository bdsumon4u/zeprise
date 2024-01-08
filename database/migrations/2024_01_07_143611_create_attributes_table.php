<?php

use App\Models\Studio;
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
        Schema::create('attributes', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Studio::class)->index();
            $table->string('name');
            $table->string('slug');
            $table->string('description')->nullable();
            $table->string('type');
            $table->boolean('is_enabled')->default(false);
            $table->boolean('is_searchable')->default(false);
            $table->boolean('is_filterable')->default(false);
            $table->timestamps();

            $table->unique(['studio_id', 'name']);
            $table->unique(['studio_id', 'slug']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attributes');
    }
};
