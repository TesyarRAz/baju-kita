<?php

namespace Tests\Feature;

use App\Models\Kategori;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class KategoriTest extends TestCase
{
    public function test_index()
    {
        $response = $this->get('/api/kategori');

        $response->assertStatus(200);
    }

    public function test_store_authorized()
    {
        $data = [
            'name' => 'kategori Test',
        ];

        $response = $this->actingAdmin()->post('/api/kategori', $data);

        $response->assertStatus(200);

        $this->assertDatabaseHas('kategoris', $data);
    }

    public function test_store_unauthorized()
    {
        $response = $this->post('/api/kategori', [
            'name' => 'kategori Test',
        ]);

        $response->assertStatus(401);
    }

    public function test_update_authorized()
    {
        $kategori = kategori::factory()->create();

        $data = [
            'id' => $kategori->id,
            'name' => 'kategori Test Update',
        ];

        $response = $this->actingAdmin()->put('/api/kategori/' . $kategori->id, $data);

        $response->assertStatus(200);

        $this->assertDatabaseHas('kategoris', $data);
    }

    public function test_update_unauthorized()
    {
        $kategori = Kategori::factory()->create();

        $data = [
            'id' => $kategori->id,
            'name' => 'kategori Test Update',
        ];

        $response = $this->put('/api/kategori/' . $kategori->id, $data);

        $response->assertStatus(401);
    }

    public function test_delete_authorized()
    {
        $kategori = kategori::factory()->create();

        $response = $this->actingAdmin()->delete('/api/kategori/' . $kategori->id);

        $response->assertStatus(200);

        $this->assertDatabaseMissing('kategoris', [
            'id' => $kategori->id,
        ]);
    }

    public function test_delete_unauthorized()
    {
        $kategori = kategori::factory()->create();

        $response = $this->delete('/api/kategori/' . $kategori->id);

        $response->assertStatus(401);
    }
}
