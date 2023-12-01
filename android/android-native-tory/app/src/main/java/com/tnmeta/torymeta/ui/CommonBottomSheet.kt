package com.tnmeta.torymeta.ui

import android.animation.ObjectAnimator
import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.ComponentActivity
import androidx.activity.OnBackPressedCallback
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.lifecycle.findViewTreeLifecycleOwner
import com.daimajia.androidanimations.library.BaseViewAnimator
import com.daimajia.androidanimations.library.YoYo
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.databinding.CommonBottomSheetBinding
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import timber.log.Timber


/**
 * 공통 하단 시트. View를 포함한 형태입니다
 */
open class CommonBottomSheet(private val parent: ViewGroup) {
    companion object {
        private const val ENTER_ANIMATION_DURATION = 200L

        fun createInRootView(activity: Activity): CommonBottomSheet {
            return CommonBottomSheet(activity.getContentView() as ViewGroup)
        }
    }

    private var onBackPressedCallback: OnBackPressedCallback? = null

    val commonBottomSheetBinding = CommonBottomSheetBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    val rootView: ConstraintLayout = commonBottomSheetBinding.root
    val context :Context = parent.context

    init {
        rootView.apply {
            visibility = View.GONE

            setOnClickListener {
                dismiss()
            }
        }
        parent.addView(rootView)

        // OnBackPressedCallback 등록
        val activity = ToryApplication.activity as? ComponentActivity

        if( activity != null ) {
            onBackPressedCallback = object: OnBackPressedCallback(true) {
                override fun handleOnBackPressed() {
                    dismiss()
                }
            }
            activity!!.onBackPressedDispatcher.addCallback(rootView.findViewTreeLifecycleOwner()!!, onBackPressedCallback!!)
        }

    }

    /**
     * View 노출
     */
    open fun show(animationDuration: Long = ENTER_ANIMATION_DURATION)  = try {

        val activity = ToryApplication.activity as? ComponentActivity
        ToryApplication.getInstance(activity!!).isShowingDialog = true

        rootView.apply {
            bringToFront()
            visibility = View.VISIBLE
        }

        // 배경 - fade in
        commonBottomSheetBinding.bg.apply {
            val toAlpha = alpha
            YoYo.with(object: BaseViewAnimator() {
                override fun prepare(target: View?) {
                    target?.alpha = 0F // need?
                    animatorAgent.playTogether(
                        ObjectAnimator.ofFloat(target, "alpha", 0F, toAlpha)
                    )
                }
            })
                .duration(animationDuration)
                .repeat(0).playOn(this)
        }

        // 컨텐츠 - move in
        commonBottomSheetBinding.content.apply {
            requestLayout()
            measure(View.MeasureSpec.UNSPECIFIED, View.MeasureSpec.UNSPECIFIED);

            YoYo.with(object: BaseViewAnimator() {
                override fun prepare(target: View?) {
                    animatorAgent.playTogether(
                        ObjectAnimator.ofFloat(target, "translationY", measuredHeight.toFloat(), 0f)
                    )
                }
            })
            .pivot(YoYo.CENTER_PIVOT, 0f)
            .duration(animationDuration)
            .repeat(0).playOn(this)

        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

    /**
     * View 삭제
     */
    fun dismiss() = try {
        val activity = ToryApplication.activity as? ComponentActivity
        ToryApplication.getInstance(activity!!).isShowingDialog = false
        parent.removeView(rootView)
        onBackPressedCallback?.remove()
    }catch (e : Exception){
        Timber.d(e.message)
    }

}