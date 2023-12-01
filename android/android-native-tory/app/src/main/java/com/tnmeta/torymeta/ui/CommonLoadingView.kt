package com.tnmeta.torymeta.ui

import android.app.Activity
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.constraintlayout.widget.ConstraintLayout
import com.tnmeta.torymeta.databinding.CommonLoadingViewBinding
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.util.*

/**
 * 공통 로딩 UI. View를 포함한 형태입니다
 */
class CommonLoadingView(val parent: ViewGroup) {
    companion object {
        fun createInRootView(activity: Activity): CommonLoadingView {
            return CommonLoadingView(activity.getContentView() as ViewGroup)
        }
    }

    val viewBinding = CommonLoadingViewBinding.inflate(LayoutInflater.from(parent.context), parent, false)

    private val rootView: ConstraintLayout by lazy {
        viewBinding.root
    }

    private var showScheduler: Timer? = null

    init {
        rootView.apply {
            setVisible(false)

            setOnClickListener {
            }
        }
        parent.addView(rootView)
    }

    private fun stopScheduler() {
        showScheduler?.cancel()
        showScheduler = null
    }

    /**
     * View 노출
     */
    fun show(isBackgroundVisible: Boolean = true, uiDelayTime: Long = 0L) = viewBinding.apply {
        rootView.apply {
            bringToFront()
            setVisible(true)
            bg.setVisible(isBackgroundVisible)
        }

        if( uiDelayTime > 0 ) {
            stopScheduler()
            contentView.setVisible(false)

            showScheduler = kotlin.concurrent.timer(initialDelay = uiDelayTime, period = uiDelayTime) {
                CoroutineScope(Dispatchers.Main).launch {
                    contentView.setVisible(true)
                }

                stopScheduler()
            }
        }
    }

    /**
     * View 숨김
     */
    fun hide() {
        rootView.apply {
            setVisible(false)
        }
    }

    /**
     * View 삭제
     */
    fun dismiss() {
        stopScheduler()
        parent.removeView(rootView)
    }
}