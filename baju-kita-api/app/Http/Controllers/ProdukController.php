<?php

namespace App\Http\Controllers;

use App\Models\Produk;
use Illuminate\Http\Request;

class ProdukController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth:sanctum', 'role:admin'])->except(['index', 'show']);
    }

    public function index()
    {
        $produk = Produk::all();

        return $this->response($produk, 1, 'Success');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required',
            'price' => 'required',
            'image' => 'nullable|file|image',
            'description' => 'required',
            'kategori_id' => 'required|exists:kategoris,id',
        ]);

        if ($request->hasFile('image') && $image = $request->file('image'))
        {
            $data['image'] = $image->storePubliclyAs('/image', $image->hashName());
        }

        $produk = Produk::create($data);

        return $this->response($produk, 1, 'Success');
    }

    public function show(Produk $produk)
    {
        return $this->response($produk, 1, 'Success');
    }

    public function update(Request $request, Produk $produk)
    {
        $data = $request->validate([
            'name' => 'required',
            'price' => 'required',
            'image' => 'nullable|file|image',
            'description' => 'required',
            'kategori_id' => 'required|exists:kategoris,id',
        ]);

        if ($request->hasFile('image') && $image = $request->file('image'))
        {
            $data['image'] = $image->storePubliclyAs('/image', $image->hashName());
        }

        $produk->update($data);

        return $this->response($produk, 1, 'Success');
    }

    public function destroy(Produk $produk)
    {
        return rescue(fn() => $produk->delete(), fn() => $this->response(null, 1, 'Gagal dihapus', 402), false);
    }
}
