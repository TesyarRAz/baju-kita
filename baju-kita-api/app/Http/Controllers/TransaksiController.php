<?php

namespace App\Http\Controllers;

use App\Models\Transaksi;
use Illuminate\Http\Request;

class TransaksiController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth:sanctum', 'role:admin'])->only(['update', 'delete']);
        $this->middleware(['auth:sanctum']);
    }

    public function index(Request $request)
    {
        $user = $request->user();

        if ($user->role === 'admin' && $request->type == 'pembeli') {
            $transaksi = Transaksi::query();
        } else {
            $transaksi = $user->transaksis();
        }

        $transaksi = $transaksi->get();

        return $this->response($transaksi, 1, 'Success');
    }

    public function store(Request $request)
    {
        $user = $request->user();

        if ($request->type == 'checkout') {
            $data = $request->validate([
                'receipt' => 'required|file|image',
            ]);

            $receipt = $request->file('receipt');

            $data['receipt'] = $receipt->storePubliclyAs('/image/receipt', $receipt->hashName());

            if ($user->detail_transaksis()->keranjang()->count() < 1) {
                return $this->response(null, 1, 'Keranjang kosong', 402);
            }

            $transaksi = $user->transaksis()->create($data);

            return $this->response($transaksi, 1, 'Success');
        }
    }

    public function show(Transaksi $transaksi)
    {
        return $this->response($transaksi, 1, 'Success');
    }

    public function update(Request $request, Transaksi $transaksi)
    {
        if ($request->type == 'update_status') {
            $data = $request->validate([
                'status' => 'required|in:request,accepted,packing,send,done',
            ]);

            $transaksi->update($data);

            return $this->response($transaksi, 1, 'Success');
        }
    }

    public function destroy(Transaksi $transaksi)
    {
        $transaksi->delete();

        return $this->response(null, 1, 'Success');
    }
}
