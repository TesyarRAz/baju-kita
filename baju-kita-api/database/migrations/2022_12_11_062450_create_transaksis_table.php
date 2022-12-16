<?php

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
        Schema::create('transaksis', function (Blueprint $table) {
            $table->id();
            $table->string('invoice_code');
            $table->unsignedInteger('total_price');
            $table->string('recipient');
            $table->string('receipt')->nullable();
            $table->enum('type', ['ambil_ditempat', 'diantarkan'])->default('ambil_ditempat');
            $table->text('address')->nullable();
            
            $table->foreignIdFor(User::class)->constrained();

            $table->enum('session_status', ['request', 'accepted', 'packing', 'send', 'done'])->default('request');

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
        Schema::dropIfExists('transaksis');
    }
};
