<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class UserTest extends TestCase
{
    public function test_unauthorized_user()
    {
        $response = $this->get('/api/user');

        $response->assertStatus(401);
    }

    public function test_login()
    {
        $user = User::factory()->create();

        $response = $this->post('/api/login', [
            'username' => $user->username,
            'password' => 'password',
        ]);

        $response->assertStatus(200);
    }

    public function test_authorized_user()
    {
        $user = User::query()->inRandomOrder()->first();

        $response = $this->actingAs($user)->get('/api/user');

        $response->assertStatus(200);
    }

    public function test_register()
    {
        $response = $this->post('/api/register', [
            'name' => 'User',
            'username' => $this->faker->userName(),
            'password' => 'password',
            'email' => $this->faker->email(),
        ]);

        $response->assertStatus(200)->assertJsonStructure([
            'code', 'data', 'message',
        ]);
    }
}
