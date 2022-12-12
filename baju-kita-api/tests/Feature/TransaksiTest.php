<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class TransaksiTest extends TestCase
{
    public function test_index()
    {
        $response = $this->actingUser()->get('/api/transaksi');

        $response->assertStatus(200);
    }
}
