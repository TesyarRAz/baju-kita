<?php

use App\Http\Controllers\KategoriController;
use App\Http\Controllers\KeranjangController;
use App\Http\Controllers\ProdukController;
use App\Http\Controllers\TransaksiController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/login', [UserController::class, 'login']);
Route::post('/register', [UserController::class, 'register']);
Route::get('/user', [UserController::class, 'index']);
Route::post('/change-password', [UserController::class, 'changePassword']);

Route::apiResource('kategori', KategoriController::class);
Route::apiResource('produk', ProdukController::class);

Route::apiResource('transaksi', TransaksiController::class);
Route::apiResource('keranjang', KeranjangController::class)->parameter('keranjang', 'produk');