package com.tnmeta.torymeta.utils.extensions

import android.app.Activity
import android.content.Context
import android.os.Build
import android.view.View
import android.view.WindowManager
import androidx.core.view.WindowCompat

object ContextExtensions {
    fun Context.getStringResId(key: String): Int {
        return resources.getIdentifier(key, "string", packageName)
    }

    fun Context.getDrawableResId(key: String): Int {
        return resources.getIdentifier(key, "drawable", packageName)
    }

    fun Context.getDimension(resId: Int): Float {
        return resources.getDimension(resId)
    }

    fun Activity.getContentView(): View {
        return window.decorView.findViewById(android.R.id.content)
    }

    fun Activity.getStatusBarHeight(): Int {
        val resId = resources.getIdentifier("status_bar_height", "dimen", "android")
        return if( resId > 0 ) resources.getDimensionPixelSize(resId)
        else 0
    }

    fun Activity.getNavigationBarHeight(): Int {
        val resId = resources.getIdentifier("navigation_bar_height", "dimen", "android")
        return if( resId > 0 ) resources.getDimensionPixelSize(resId)
        else 0
    }

    fun Activity.setStatusBarTransparent() {
        window.setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)

        if( Build.VERSION.SDK_INT >= 30 ) {
            WindowCompat.setDecorFitsSystemWindows(window, false)
        }
    }
}