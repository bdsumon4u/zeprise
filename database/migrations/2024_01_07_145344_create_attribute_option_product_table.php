<?php

use App\Models\Attribute;
use App\Models\Option;
use App\Models\Shop\Product;
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
        Schema::create('attribute_option_product', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Attribute::class)->index();
            $table->foreignIdFor(Option::class)->index();
            $table->foreignIdFor(Product::class)->index();
            $table->string('custom_value')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attribute_option_product');
    }
};
