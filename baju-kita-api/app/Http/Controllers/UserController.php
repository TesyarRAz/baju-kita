<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function __construct() {
        $this->middleware(['auth:sanctum'])->only(['index']);
    }

    public function index()
    {
        $user = auth()->user();

        return $this->response($user, 1, 'Success');
    }
    
    public function login(Request $request)
    {
        $credentials = $request->validate([
            'username' => 'required',
            'password' => 'required',
        ]);

        if (auth()->attempt($credentials))
        {
            $user = auth()->user();

            $token = $user->createToken('mobile-login');
            
            return $this->response([
                'token' => $token->plainTextToken,
                'user' => $user,
            ], 1, 'Success');
        }

        return $this->response(null, 0, 'Error', 401);
    }

    public function register(Request $request)
    {
        $data = $request->validate([
            'name' => 'required',
            'username' => 'required',
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $data['password'] = Hash::make($data['password']);

        $user = User::create($data);

        return $this->response($user, 1, 'Success');
    }
}
