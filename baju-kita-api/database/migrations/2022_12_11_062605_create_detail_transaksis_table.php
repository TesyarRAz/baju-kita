<?php

use App\Models\Produk;
use App\Models\Transaksi;
use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detail_transaksis', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('qty');
            $table->foreignIdFor(Produk::class)->constrained();
            $table->foreignIdFor(User::class)->constrained();
            $table->foreignIdFor(Transaksi::class)->nullable()->constrained()->cascadeOnDelete();
            
            $table->unsignedInteger('total_price');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('detail_transaksis');
    }
};
