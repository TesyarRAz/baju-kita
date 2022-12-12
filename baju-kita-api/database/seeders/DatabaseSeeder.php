<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Kategori;
use App\Models\Produk;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'name' => 'Admin',
            'username' => 'admin',
            'email' => 'admin@localhost.com',
            'password' => Hash::make('password'),
            'role' => 'admin',
        ]);

        User::create([
            'name' => 'User',
            'username' => 'user',
            'email' => 'user@localhost.com',
            'password' => Hash::make('password'),
            'role' => 'user',
        ]);

        $kategoris = [
            'kemeja' => Kategori::create(['name' => 'Kemeja']),
            'jeans' => Kategori::create(['name' => 'Jeans']),
            'hoodie' => Kategori::create(['name' => 'Hoodie']),
            't-shirt' => Kategori::create(['name' => 'T-Shirt']),
        ];

        foreach ($this->dummyProduk() as $dummy)
        {
            Produk::create([
                'kategori_id' => $kategoris[$dummy['kategori']]->id,
                'name' => $dummy['nama'],
                'price' => str_replace('_', '', $dummy['harga']),
                'image' => $dummy['image'],
                'bahan' => $dummy['bahan'],
                'stok' => $dummy['stok'],
            ]);
        }
    }

    private function dummyProduk() {
        return [
            [
                'kategori' => 'hoodie',
                'nama' => 'Hoodie Byone 1',
                'harga' => '350_000',
                'image' => 'images/Jaket/hbyone1.jpg',
                'bahan' => 'Cotton Fleece Gramasi 330',
                'stok' => '100',
            ],
            [
                'kategori' => 'hoodie',
                'nama' => 'Hoodie Byone 2',
                'harga' => '350_000',
                'image' => 'images/Jaket/hbyone2.webp',
                'bahan' => 'Denim Premium',
                'stok' => '100',
            ],
            [
                'kategori' => 'hoodie',
                'nama' => 'Hoodie Byone 3',
                'harga' => '285_000',
                'image' => 'images/Jaket/hbyone3.webp',
                'bahan' => 'Cotton Fleece Gramasi 300',
                'stok' => '100',
            ],
            [
                'kategori' => 'hoodie',
                'nama' => 'Hoodie Byone 4',
                'harga' => '350_000',
                'image' => 'images/Jaket/hbyone4.webp',
                'bahan' => 'Denim Premiun',
                'stok' => '100',
            ],
            [
                'kategori' => 'hoodie',
                'nama' => 'Hoodie Byone 5',
                'harga' => '285_000',
                'image' => 'images/Jaket/hbyone5.jpg',
                'bahan' => 'Cotton Fleece Gramasi 300',
                'stok' => '100',
            ],
            [
                'kategori' => 'hoodie',
                'nama' => 'Hoodie Byone 6',
                'harga' => '350_000',
                'image' => 'images/Jaket/hbyone6.jpg',
                'bahan' => 'Cotton Fleece Gramasi 330',
                'stok' => '100',
            ],
            [
                'kategori' => 'hoodie',
                'nama' => 'Hoodie Byone 7',
                'harga' => '350_000',
                'image' => 'images/Jaket/hbyone7.jpg',
                'bahan' => 'Cotton Fleece Gramasi 330',
                'stok' => '100',
            ],
        
            [
                'kategori' => 'jeans',
                'nama' => 'Jeans Denim 1',
                'harga' => '488_000',
                'image' => 'images/Jeans/jdenim1.jpg',
                'bahan' => '100% Non-stretch 15 OZ Denim',
                'stok' => '100',
            ],
            [
                'kategori' => 'jeans',
                'nama' => 'Jeans Denim 2',
                'harga' => '398_000',
                'image' => 'images/Jeans/jdenim2.jpg',
                'bahan' => '100% Cotton Non-stretch',
                'stok' => '100',
            ],
            [
                'kategori' => 'jeans',
                'nama' => 'Jeans Denim 3',
                'harga' => '498_000',
                'image' => 'images/Jeans/jdenim3.jpg',
                'bahan' => '100% Non-stretch 15 OZ Denim',
                'stok' => '100',
            ],
            [
                'kategori' => 'jeans',
                'nama' => 'Jeans Denim 4',
                'harga' => '488_000',
                'image' => 'images/Jeans/jdenim4.jpg',
                'bahan' => '100% Non-stretch 15 OZ Denim',
                'stok' => '100',
            ],
            [
                'kategori' => 'jeans',
                'nama' => 'Jeans Denim 5',
                'harga' => '588_000',
                'image' => 'images/Jeans/jdenim5.jpg',
                'bahan' => '98% Cotton 2% Elastane',
                'stok' => '100',
            ],
            [
                'kategori' => 'jeans',
                'nama' => 'Jeans Denim 6',
                'harga' => '498_000',
                'image' => 'images/Jeans/jdenim6.jpg',
                'bahan' => '98% Cotton 2% Elastane',
                'stok' => '100',
            ],
            [
                'kategori' => 'jeans',
                'nama' => 'Jeans Denim 7',
                'harga' => '588_000',
                'image' => 'images/Jeans/jdenim7.jpg',
                'bahan' => '98% Cotton 2% Elastane',
                'stok' => '100',
            ],
        
            [
                'kategori' => 'kemeja',
                'nama' => 'Kemeja Byone 1',
                'harga' => '210_000',
                'image' => 'images/Kemeja/kbyone1.webp',
                'bahan' => 'Material Toyobo Tojiro Japan',
                'stok' => '100',
            ],
            [
                'kategori' => 'kemeja',
                'nama' => 'Kemeja Byone 2',
                'harga' => '210_000',
                'image' => 'images/Kemeja/kbyone2.webp',
                'bahan' => 'Material Toyobo Tojiro Japan',
                'stok' => '100',
            ],
            [
                'kategori' => 'kemeja',
                'nama' => 'Kemeja Byone 3',
                'harga' => '210_000',
                'image' => 'images/Kemeja/kbyone3.webp',
                'bahan' => 'Material Toyobo Tojiro Japan',
                'stok' => '100',
            ],
            [
                'kategori' => 'kemeja',
                'nama' => 'Kemeja Byone 4',
                'harga' => '210_000',
                'image' => 'images/Kemeja/kbyone4.webp',
                'bahan' => 'Material Toyobo Tojiro Japan',
                'stok' => '100',
            ],
        
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 1',
                'harga' => '150_000',
                'image' => 'images/T-Shirt/tbyone1.webp',
                'bahan' => 'Material Cotton 24s Bali',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 2',
                'harga' => '165_000',
                'image' => 'images/T-Shirt/tbyone2.webp',
                'bahan' => 'Material Cotton 24s Bali',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 3',
                'harga' => '135_000',
                'image' => 'images/T-Shirt/tbyone3.webp',
                'bahan' => 'Material Cotton Combed 24s',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 4',
                'harga' => '140_000',
                'image' => 'images/T-Shirt/tbyone4.webp',
                'bahan' => 'Material Cotton Combed 24s',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 5',
                'harga' => '130_000',
                'image' => 'images/T-Shirt/tbyone5.webp',
                'bahan' => 'Material Cotton Combed 24s',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 6',
                'harga' => '160_000',
                'image' => 'images/T-Shirt/tbyone6.webp',
                'bahan' => 'Material Cotton 24s Bali',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 7',
                'harga' => '145_000',
                'image' => 'images/T-Shirt/tbyone7.webp',
                'bahan' => 'Material Cotton 24s Bali',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 8',
                'harga' => '165_000',
                'image' => 'images/T-Shirt/tbyone8.webp',
                'bahan' => 'Material Cotton 24s Bali',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 9',
                'harga' => '140_000',
                'image' => 'images/T-Shirt/tbyone9.jpg',
                'bahan' => 'Material Cotton Combed 24s',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 10',
                'harga' => '140_000',
                'image' => 'images/T-Shirt/tbyone10.jpg',
                'bahan' => 'Material Cotton Combed 24s',
                'stok' => '100',
            ],
            [
                'kategori' => 't-shirt',
                'nama' => 'T-Shirt Byone 11',
                'harga' => '155_000',
                'image' => 'images/T-Shirt/tbyone11.jpg',
                'bahan' => 'Material Cotton 24s Bali',
                'stok' => '100',
            ],
        ];
    }
}
