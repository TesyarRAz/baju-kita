<?php

namespace App\Http\Controllers;

use App\Models\DetailTransaksi;
use App\Models\Produk;
use Illuminate\Http\Request;

class KeranjangController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth:sanctum']);
    }

    public function index(Request $request)
    {
        $keranjang = $request->user()->detail_transaksis()->keranjang()->with('produk')->get();

        return $this->response($keranjang, 1, "Success");
    }

    public function store(Request $request)
    {
        $request->validate([
            'produk_id' => 'required|exists:produks,id',
            'qty' => 'required|numeric',
        ]);

        $produk_id = $request->input('produk_id');
        $qty = $request->input('qty');

        $produk = Produk::find($produk_id);

        $detail_transaksi = $request->user()->detail_transaksis()->keranjang()->firstOrNew([
            'produk_id' => $produk_id,
        ], ['qty' => 0]);

        $detail_transaksi->qty += $detail_transaksi->qty + $qty;
        $detail_transaksi->total_price = $produk->price * $detail_transaksi->qty;
        $detail_transaksi->save();

        return $this->response($detail_transaksi, 1, 'Success');
    }

    public function update(Request $request, Produk $produk)
    {
        $request->validate([
            'qty' => 'required|numeric',
        ]);

        $qty = $request->input('qty');

        if ($detail_transaksi = $request->user()->detail_transaksis()->keranjang()->where('produk_id', $produk->id)->firstOrFail())
        {
            $detail_transaksi->update([
                'qty' => $qty,
                'total_price' => $qty * $detail_transaksi->produk->price,
            ]);

            return $this->response($detail_transaksi, 1, 'Success');
        }

        return $this->response($detail_transaksi, 0, 'Failed', 402);
    }

    public function destroy(Request $request, Produk $produk)
    {
        return rescue(
            fn() => $request->user()->detail_transaksis()->keranjang()->where('produk_id', $produk->id)->delete(),
            fn() => $this->response(null, 1, 'Gagal dihapus', 402),
            false,
        );
    }
}
