package com.tnmeta.torymeta.api

import com.tnmeta.torymeta.ToryApplication
import hu.akarnokd.rxjava3.retrofit.RxJava3CallAdapterFactory
import okhttp3.OkHttpClient
import timber.log.Timber
import java.util.concurrent.TimeUnit

object Client {
    private const val authorization             = "Authorization"
    private const val contentType               = "Content-Type"
    private const val applcationType            = "application/json"
    private const val multiPartType             = "multipart/form-data"

    private const val TimerOutValue             = 30L

    fun default(): Api {

        val client = OkHttpClient.Builder()
            .addInterceptor {
                val activity = ToryApplication.activity!!
                val repository = ToryApplication.getRepository(activity)

                val token = if(repository.getLoginToken().isEmpty()) ""
                            else "Bearer ${repository.getLoginToken()}"

                Timber.d("token $token")
                val request = it.request().newBuilder().apply {
                    val url = it.request().url.toString()

                    if( url.contains(Api.Url.UPDATE_PROFIlE_IMAGE) ) {
                        addHeader(contentType, multiPartType)
                    } else {
                        addHeader(contentType, applcationType)
                    }
                }.addHeader(authorization , token).build()
                it.proceed(request)
            }
            .connectTimeout(TimerOutValue, TimeUnit.SECONDS)
            .readTimeout(TimerOutValue, TimeUnit.SECONDS)
            .writeTimeout(TimerOutValue, TimeUnit.SECONDS)

        return RetrofitInterface.create(client)
            .baseUrl(Api.Url.BASE)
            .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
            .build()
            .create(Api::class.java)
    }

    fun nft(): Api {
        val client = OkHttpClient.Builder()
            .addInterceptor {
                val request = it.request().newBuilder()
                    .addHeader(contentType, applcationType)
                    .build()
                it.proceed(request)
            }
            .connectTimeout(TimerOutValue, TimeUnit.SECONDS)
            .readTimeout(TimerOutValue, TimeUnit.SECONDS)
            .writeTimeout(TimerOutValue, TimeUnit.SECONDS)


        return RetrofitInterface.create(client)
            .baseUrl(Api.NFTUrl.BASE)
            .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
            .build()
            .create(Api::class.java)
    }

    fun messenger() : Api {
        val client = OkHttpClient.Builder()
            .addInterceptor {
                val activity = ToryApplication.activity!!
                val repository = ToryApplication.getRepository(activity)

                val token = if(repository.getLoginToken().isEmpty()) ""
                                else "${repository.getLoginToken()}"

                val request = it.request().newBuilder().apply {
                    addHeader(contentType, applcationType)
                }
                    .addHeader(authorization , token)
                    .build()
                it.proceed(request)
            }
            .connectTimeout(TimerOutValue, TimeUnit.SECONDS)
            .readTimeout(TimerOutValue, TimeUnit.SECONDS)
            .writeTimeout(TimerOutValue, TimeUnit.SECONDS)

        return RetrofitInterface.create(client)
            .baseUrl(Api.MessengerUrl.BASE)
            .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
            .build()
            .create(Api::class.java)

    }

    fun metabus() : Api {
        val client = OkHttpClient.Builder()
            .addInterceptor {
                val request = it.request().newBuilder().apply {
                    addHeader(contentType, applcationType)
                }.build()
                it.proceed(request)
            }
            .connectTimeout(TimerOutValue, TimeUnit.SECONDS)
            .readTimeout(TimerOutValue, TimeUnit.SECONDS)
            .writeTimeout(TimerOutValue, TimeUnit.SECONDS)

        return RetrofitInterface.create(client)
            .baseUrl(Api.MetaBusUrl.BASE)
            .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
            .build()
            .create(Api::class.java)
    }


    fun apiVersion2() : Api {
        val client = OkHttpClient.Builder()
            .addInterceptor {
                val activity = ToryApplication.activity!!
                val repository = ToryApplication.getRepository(activity)

                val token = if(repository.getLoginToken().isEmpty()) ""
                                 else "Bearer ${repository.getLoginToken()}"

                Timber.d("token $token")
                val request = it.request().newBuilder().apply {
                    addHeader(contentType, applcationType)
                    addHeader("X-API-VERSION", "2")
                }.addHeader(authorization , token).build()
                it.proceed(request)
            }
            .connectTimeout(TimerOutValue, TimeUnit.SECONDS)
            .readTimeout(TimerOutValue, TimeUnit.SECONDS)
            .writeTimeout(TimerOutValue, TimeUnit.SECONDS)

        return RetrofitInterface.create(client)
            .baseUrl(Api.Url.BASE)
            .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
            .build()
            .create(Api::class.java)
    }


}