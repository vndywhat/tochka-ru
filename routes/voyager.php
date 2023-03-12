<?php

use Illuminate\Support\Facades\Route;
use TCG\Voyager\Facades\Voyager;

Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();

    Route::get('posts/{id}/edit', [
        'uses' => 'App\Http\Controllers\Voyager\PostController@edit',
        'as' => 'voyager.posts.edit'
    ]);
});
