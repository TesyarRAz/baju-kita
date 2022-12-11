<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class Role
{
    public function handle(Request $request, Closure $next, ...$guards)
    {
        abort_unless(in_array($request->user()->role, $guards), 401);

        return $next($request);
    }
}
