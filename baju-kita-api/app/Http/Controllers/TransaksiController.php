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

        if ($user->role == 'admin') {
            $transaksi = Transaksi::query();
        } else {
            $transaksi = $user->transaksis();
        }

        $transaksi->with('detail_transaksis.produk');

        $transaksi = $transaksi->orderByRaw("FIELD(session_status, 'prepared', 'request', 'accepted', 'packing', 'send', 'done')")->get();

        return $this->response($transaksi, 1, 'Success');
    }

    public function store(Request $request)
    {
        $user = $request->user();

        if ($request->mode == 'checkout') {
            $data = $request->validate([
                'type' => 'required|in:ambil_ditempat,diantarkan',
            ]);

            if ($user->detail_transaksis()->keranjang()->count() < 1) {
                return $this->response(null, 1, 'Keranjang kosong', 402);
            }

            $data['session_status'] = $data['type'] == 'ambil_ditempat' ? 'request' : 'prepared';
            $data['recipient'] = $user->name;
            $data['total_price'] = $user->detail_transaksis()->keranjang()->sum('total_price');

            $transaksi = $user->transaksis()->create($data);

            $user->detail_transaksis()->keranjang()->update(['transaksi_id' => $transaksi->id]);

            $transaksi->load('detail_transaksis.produk');
            return $this->response($transaksi, 1, 'Success');
        }

        if ($request->mode == 'checkout_diantarkan') {
            $data = $request->validate([
                'receipt' => 'required|file|image',
                'recipient' => 'required',
                'address' => 'required',
                'transaksi_id' => 'required',
            ]);

            $transaksi = $user->role == 'admin' ? Transaksi::query() : $user->transaksis();

            $transaksi = $transaksi->whereKey($data['transaksi_id'])->firstOrFail();

            $receipt = $request->file('receipt');

            $data['session_status'] = 'request';
            $data['receipt'] = $receipt->storeAs('/image/receipt', $receipt->hashName(), 'public');

            $transaksi->update($data);
            $transaksi->load('detail_transaksis.produk');

            return $this->response($transaksi, 1, 'Success');
        }

        if ($user->role == 'admin')
        {
            if ($request->mode == 'update_status')
            {
                $data = $request->validate([
                    'session_status' => 'required|in:prepared,request,accepted,packing,send,done',
                    'transaksi_id' => 'required|exists:transaksis,id',
                ]);

                $transaksi = Transaksi::findOrFail($data['transaksi_id']);

                unset($data['transaksi_id']);

                $transaksi->update($data);
                $transaksi->load('detail_transaksis.produk');

                return $this->response($transaksi, 1, 'Success');
            }
        }

        return $this->response(null, 0, 'Failed', 402);
    }

    public function show(Transaksi $transaksi)
    {
        return $this->response($transaksi, 1, 'Success');
    }

    public function update(Request $request, Transaksi $transaksi)
    {
        if ($request->type == 'update_status') {
            $data = $request->validate([
                'session_status' => 'required|in:request,accepted,packing,send,done',
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
