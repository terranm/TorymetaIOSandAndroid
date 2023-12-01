package com.tnmeta.torymeta.control.unity

import android.content.Context
import android.content.res.TypedArray
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import androidx.constraintlayout.widget.ConstraintLayout
import com.pnikosis.materialishprogress.ProgressWheel
import com.tnmeta.torymeta.R


class UnityContainer : ConstraintLayout {

    private lateinit var unitybg : ConstraintLayout
    constructor(context: Context) : super(context) {
        init(context)
    }

    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {
        init(context)
        getAttrs(attrs = attrs)
    }

    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        init(context)

        getAttrs(attrs = attrs)
    }

    private fun init(context: Context) {
        val view = LayoutInflater.from(context).inflate(R.layout.custom_unity_container, this, false)
        addView(view)

        unitybg = view.findViewById(R.id.unity_bg)

    }


    private fun getAttrs(attrs: AttributeSet?){
        val typedArray = context.obtainStyledAttributes(attrs, R.styleable.CustomUnityContainer)
        setTypeArray(typedArray, attrs)
    }


    private fun setTypeArray(typedArray : TypedArray, attrs: AttributeSet?) {
        val bgColor = typedArray.getColor(R.styleable.CustomUnityContainer_bg, 0)
        unitybg.setBackgroundColor(bgColor)

        val isloading = typedArray.getBoolean(R.styleable.CustomUnityContainer_showLoading, false)

        typedArray.recycle()
    }

    fun setBgColor(color : Int) {
        unitybg.setBackgroundColor(color)
    }

}
