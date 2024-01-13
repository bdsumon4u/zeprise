<?php

use App\Models\Attribute;
use App\Models\Branch;
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
        Schema::create('options', function (Blueprint $table) {
            $table->id();
            $table->foreignId('owner_id')->index();
            $table->foreignIdFor(Attribute::class)->index();
            $table->string('value', 50);
            $table->string('key');
            $table->unsignedSmallInteger('position')->default(0);
            $table->timestamps();

            $table->unique(['owner_id', 'key']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('options');
    }
};
