package com.tnmeta.torymeta.unity.unitycall

import android.app.Activity
import android.os.Build
import android.window.OnBackInvokedDispatcher
import androidx.activity.OnBackPressedCallback
import timber.log.Timber

class UnityNativeBack : Any() {

    companion object {
        val TAG : String = UnityNativeBack::class.java.simpleName

        @JvmStatic
        val instance by lazy { UnityNativeBack() }
    }

    /**
     * onNativeBack
     */
    fun onNativeBack(currentActivity: Activity) = try {
//                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//                        currentActivity.onBackInvokedDispatcher.registerOnBackInvokedCallback(
//                            OnBackInvokedDispatcher.PRIORITY_DEFAULT
//                        ) {
//                            Timber.tag(TAG).d("NativeBack - 2")
//
//                            //exitOnBackPressed()
//                            //currentActivity.onBackPressedDispatcher.onBackPressed()
//                            onBackPressedDispatcher.onBackPressed()
//                        }
//
//                    } else {
//                        onBackPressedDispatcher.addCallback(this,
//                            object : OnBackPressedCallback(true) {
//                                override fun handleOnBackPressed() {
//                                    Timber.tag(TAG).d("NativeBack - 3")
//
//                                    onBackPressedDispatcher.onBackPressed()
//                                }
//                            })
//
//                        currentActivity.onBackInvokedDispatcher
//                    }

        currentActivity.onBackPressed()


    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


}