<?php

namespace App\Models\Shop;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Staudenmeir\LaravelAdjacencyList\Eloquent\HasRecursiveRelationships;
use Staudenmeir\LaravelAdjacencyList\Eloquent\Traits\HasRecursiveRelationshipScopes;

class Category extends Model implements HasMedia
{
    use HasFactory;
    use HasRecursiveRelationships;
    use HasRecursiveRelationshipScopes;
    use InteractsWithMedia;

    public function getCustomPaths()
    {
        return [
            [
                'name' => 'name_path',
                'column' => 'name',
                'separator' => ' / ',
            ],
        ];
    }

    public function products(): BelongsToMany
    {
        return $this->belongsToMany(Product::class);
    }
}
