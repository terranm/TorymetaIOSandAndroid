package com.tnmeta.torymeta.api

import android.util.Log
import com.tnmeta.torymeta.BuildConfig
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.*
import retrofit2.converter.gson.GsonConverterFactory
import java.lang.reflect.ParameterizedType
import java.lang.reflect.Type

/**
 * Retrofit 인터페이스
 */
object RetrofitInterface {
    const val TAG = "RetrofitInterface"

    fun create(client: OkHttpClient.Builder): Retrofit.Builder {
        client.addInterceptor(HttpLoggingInterceptor().apply {

            level = if(BuildConfig.DEBUG)
                HttpLoggingInterceptor.Level.BODY
            else
                HttpLoggingInterceptor.Level.NONE

            //level = HttpLoggingInterceptor.Level.BODY
        })

        return Retrofit.Builder()
            .addConverterFactory(GsonConverterFactory.create())
            .client(client.build())
    }
}