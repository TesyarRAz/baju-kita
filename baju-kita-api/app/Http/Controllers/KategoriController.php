<?php

namespace App\Http\Controllers;

use App\Models\Kategori;
use Illuminate\Http\Request;

class KategoriController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth:sanctum', 'role:admin'])->except(['index', 'show']);
    }

    public function index()
    {
        $kategori = Kategori::all();

        return $this->response($kategori, 1, 'Success');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required',
        ]);

        $kategori = Kategori::create($data);

        return $this->response($kategori, 1, 'Success');
    }

    public function show(Kategori $kategori)
    {
        return $this->response($kategori, 1, 'Success');
    }

    public function update(Request $request, Kategori $kategori)
    {
        $data = $request->validate([
            'name' => 'required',
        ]);

        $kategori = $kategori->update($data);

        return $this->response($kategori, 1, 'Success');
    }

    public function destroy(Kategori $kategori)
    {
        return rescue(fn() => $kategori->delete(), fn() => $this->response(null, 1, 'Gagal dihapus', 402), false);
    }
}
