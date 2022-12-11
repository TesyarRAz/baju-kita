<?php

namespace Tests\Feature;

use App\Models\Kategori;
use App\Models\Produk;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class ProdukTest extends TestCase
{
    public function test_index()
    {
        $response = $this->get('/api/produk');

        $response->assertStatus(200);
    }

    public function test_store_authorized()
    {
        $kategori = Kategori::factory()->create();

        $data = [
            'name' => 'Produk Test',
            'price' => '100000',
            'kategori_id' => $kategori->id,
            'description' => 'description random',
        ];

        $response = $this->actingAdmin()->post('/api/produk', $data);

        $response->assertStatus(200);

        $this->assertDatabaseHas('produks', $data);
    }

    public function test_store_unauthorized()
    {
        $kategori = Kategori::factory()->create();

        $response = $this->post('/api/produk', [
            'name' => 'Produk Test',
            'price' => '100000',
            'kategori_id' => $kategori->id,
            'description' => 'description random',
        ]);

        $response->assertStatus(401);
    }

    public function test_update_authorized()
    {
        $kategori = Kategori::factory()->create();
        $produk = Produk::factory()->create();

        $data = [
            'id' => $produk->id,
            'name' => 'Produk Test',
            'price' => '100000',
            'kategori_id' => $kategori->id,
            'description' => 'description random',
        ];

        $response = $this->actingAdmin()->put('/api/produk/' . $produk->id, $data);

        $response->assertStatus(200);

        $this->assertDatabaseHas('produks', $data);
    }

    public function test_update_unauthorized()
    {
        $kategori = Kategori::factory()->create();
        $produk = Produk::factory()->create();

        $data = [
            'id' => $produk->id,
            'name' => 'Produk Test',
            'price' => '100000',
            'kategori_id' => $kategori->id,
            'description' => 'description random',
        ];

        $response = $this->put('/api/produk/' . $produk->id, $data);

        $response->assertStatus(401);
    }

    public function test_delete_authorized()
    {
        $produk = Produk::factory()->create();

        $response = $this->actingAdmin()->delete('/api/produk/' . $produk->id);

        $response->assertStatus(200);

        $this->assertDatabaseMissing('produks', [
            'id' => $produk->id,
        ]);
    }

    public function test_delete_unauthorized()
    {
        $produk = Produk::factory()->create();

        $response = $this->delete('/api/produk/' . $produk->id);

        $response->assertStatus(401);
    }
}
