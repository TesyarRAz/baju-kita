<?php

namespace App\Http\Controllers;

use App\Models\Kategori;
use App\Models\Produk;
use GuzzleHttp\Handler\Proxy;
use Illuminate\Http\Request;

class ProdukController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth:sanctum', 'role:admin'])->except(['index', 'show']);
    }

    public function index(Request $request)
    {
        if ($request->type == 'recommended')
        {
            $kategori = Kategori::all();

            $produk = collect();

            foreach ($kategori as $item)
            {
                $produk = $produk->merge(Produk::orderByBuyed()->where('kategori_id', $item->id)->take(2)->get());
            }

            return $this->response($produk, 1, 'Success');
        }

        $produk = Produk::orderByBuyed();

        if ($kategori_id = $request->kategori_id) {
            $produk->where('kategori_id', $kategori_id);
        }

        if ($search = $request->search) {
            $produk->where('name', 'like', '%' . $search . '%');
        }

        $produk = $produk->get();

        return $this->response($produk, 1, 'Success');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required',
            'price' => 'required',
            'image' => 'nullable|file|image',
            'bahan' => 'required',
            'stok' => 'required|numeric',
            'kategori_id' => 'required|exists:kategoris,id',
        ]);

        if ($request->hasFile('image') && $image = $request->file('image'))
        {
            $data['image'] = $image->storeAs('/image', $image->hashName(), 'public');
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
            'bahan' => 'required',
            'stok' => 'required|numeric',
            'kategori_id' => 'required|exists:kategoris,id',
        ]);

        if ($request->hasFile('image') && $image = $request->file('image'))
        {
            $data['image'] = $image->storeAs('/image', $image->hashName(), 'public');
        }

        $produk->update($data);

        return $this->response($produk, 1, 'Success');
    }

    public function destroy(Produk $produk)
    {
        return rescue(fn() => $produk->delete(), fn() => $this->response(null, 1, 'Gagal dihapus', 402), false);
    }
}
