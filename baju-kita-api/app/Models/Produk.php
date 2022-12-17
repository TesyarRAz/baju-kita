<?php

namespace App\Models;

use App\Casts\PublicFileClient;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Produk extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $casts = [
        'price' => 'integer',
        'stok' => 'integer',
        'image' => PublicFileClient::class,
        'kategori_id' => 'integer',
    ];

    public function kategori()
    {
        return $this->belongsTo(Kategori::class);
    }

    public function detail_transaksis()
    {
        return $this->hasMany(DetailTransaksi::class);
    }

    public function scopeOrderByBuyed(Builder $query)
    {
        return $query->withCount(['detail_transaksis' => fn($query) => $query
            ->whereNot('transaksi_id', null),
        ])
        ->orderByDesc('detail_transaksis_count');
    }
}
