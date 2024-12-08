<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Property;
use Illuminate\Http\Request;

class PropertyController extends Controller
{
    // GET: Fetch all properties
    public function index()
    {
        return response()->json(Property::all(), 200);
    }

    // POST: Add a new property
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'status' => 'nullable',
            'address' => 'required|string',
            'price' => 'required|numeric',
        ]);

        $property = Property::create($validated);

        return response()->json($property, 201);
    }

    // PUT: Update a property
    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'address' => 'required|string',
            'status' => 'nullable',
            'price' => 'required|numeric',
        ]);

        $property = Property::find($id);

        if (!$property) {
            return response()->json(['message' => 'Property not found'], 404);
        }

        $property->update($validated);

        return response()->json($property, 200);
    }

    // DELETE: Delete a property
    public function destroy($id)
    {
        $property = Property::find($id);

        if (!$property) {
            return response()->json(['message' => 'Property not found'], 404);
        }

        $property->delete();

        return response()->json(['message' => 'Property deleted'], 200);
    }
}
