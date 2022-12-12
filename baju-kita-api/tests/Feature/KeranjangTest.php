<?php

namespace Tests\Feature;

use App\Models\Produk;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class KeranjangTest extends TestCase
{
    public function test_list()
    {
        $response = $this->actingUser()->get('/api/keranjang');

        $response->assertStatus(200);
    }
    
    public function test_store()
    {
        $produk = Produk::factory()->create();
        $user = $this->actingUser();

        $response = $user->post('/api/keranjang', [
            'produk_id' => $produk->id,
            'qty' => 1,
        ]);

        $response->assertStatus(200);

        $this->assertDatabaseHas('detail_transaksis', [
            'user_id' => auth()->id(),
            'produk_id' => $produk->id,
            'qty' => 1,
            'total_price' => $produk->price,
            'transaksi_id' => null,
        ]);
    }

    public function test_update()
    {
        $produk = Produk::factory()->create();
        
        $user = $this->actingUser();

        $user->post('/api/keranjang', [
            'produk_id' => $produk->id,
            'qty' => 1,
        ]);

        $response = $user->put('/api/keranjang/' . $produk->id, [
            'qty' => 123,
        ]);

        $response->assertStatus(200);

        $this->assertDatabaseHas('detail_transaksis', [
            'user_id' => auth()->id(),
            'produk_id' => $produk->id,
            'transaksi_id' => null,
            'qty' => 123,
        ]);
    }

    public function test_delete()
    {
        $produk = Produk::factory()->create();
        $user = $this->actingUser();

        $response = $user->delete('/api/keranjang/' . $produk->id);

        $response->assertStatus(200);

        $this->assertDatabaseMissing('detail_transaksis', [
            'user_id' => auth()->id(),
            'produk_id' => $produk->id,
            'transaksi_id' => null,
            'qty' => 123,
        ]);
    }
}
