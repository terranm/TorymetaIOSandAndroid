package com.tnmeta.torymeta.control

import android.content.Context
import android.content.res.TypedArray
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import com.tnmeta.torymeta.R


class ToryLoungeButton : ConstraintLayout {
    private lateinit var buttonbg : ConstraintLayout


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
        val view = LayoutInflater.from(context).inflate(R.layout.tory_lounge_button, this, false)
        addView(view)

        buttonbg = view.findViewById(R.id.tory_lounge)

    }


    private fun getAttrs(attrs: AttributeSet?){
        val typedArray = context.obtainStyledAttributes(attrs, R.styleable.ToryLoungeButtonAttr)
        setTypeArray(typedArray, attrs)
    }


    private fun setTypeArray(typedArray : TypedArray, attrs: AttributeSet?) {
        val resoucebg = typedArray.getResourceId(R.styleable.ToryLoungeButtonAttr_back_ground, 0)
        buttonbg.setBackgroundResource(resoucebg)

        typedArray.recycle()
    }

}