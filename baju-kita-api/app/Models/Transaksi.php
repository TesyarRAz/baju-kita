<?php

namespace App\Models;

use App\Casts\PublicFileClient;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaksi extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $casts = [
        'total_price' => 'integer',
        'receipt' => PublicFileClient::class,
    ];

    public static function booting() {
        static::creating(function($transaksi) {
            $transaksi->invoice_code = 'INV' . now()->format('dmyhis');
        });
    }

    public function detail_transaksis()
    {
        return $this->hasMany(DetailTransaksi::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
