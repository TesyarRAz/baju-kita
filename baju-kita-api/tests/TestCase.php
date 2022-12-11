<?php

namespace Tests;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\TestCase as BaseTestCase;

abstract class TestCase extends BaseTestCase
{
    use CreatesApplication, RefreshDatabase;

    public $seed = true;

    public function actingUser()
    {
        return $this->actingAs(User::where('role', 'user')->inRandomOrder()->first());
    }

    public function actingAdmin()
    {
        return $this->actingAs(User::where('role', 'admin')->inRandomOrder()->first());
    }
}
