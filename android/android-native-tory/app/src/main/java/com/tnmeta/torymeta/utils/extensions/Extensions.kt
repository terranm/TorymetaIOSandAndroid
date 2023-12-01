package com.tnmeta.torymeta.utils.extensions

import android.app.Activity
import android.content.Context
import android.os.Build
import android.view.View
import android.view.WindowManager
import androidx.core.view.WindowCompat
import androidx.lifecycle.MutableLiveData

object Extensions {
    fun <T> MutableLiveData<T>.update(block: (T) -> Unit) {
        value?.let {
            block(it)
            value = it
        }
    }

    fun <T> MutableLiveData<T>.postUpdate(block: (T) -> Unit) {
        value?.let {
            block(it)
            postValue(it)
        }
    }
}