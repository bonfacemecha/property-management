<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Property extends Model
{
    use HasFactory;

     // Define the fields that are allowed to be mass-assigned
     protected $fillable = [
        'name',
        'address',
        'status',
        'price',
    ];
}