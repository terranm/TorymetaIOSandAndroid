package com.tnmeta.torymeta.control.extension

import android.content.Context
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import androidx.annotation.DrawableRes
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.RecyclerView


fun RecyclerView.setDivider(@DrawableRes drawableRes: Int) {
    val divider = DividerItemDecoration(
        this.context,
        DividerItemDecoration.VERTICAL
    )
    val drawable = ContextCompat.getDrawable(
        this.context,
        drawableRes
    )
    drawable?.let {
        divider.setDrawable(it)
        addItemDecoration(divider)
    }
}


class DividerItemDecoration(
    context: Context,
    resId: Int,
    private val paddingLeft: Int,
    private val paddingRight: Int
) : RecyclerView.ItemDecoration() {

    private var mDivider: Drawable? = null

    init {
        mDivider = ContextCompat.getDrawable(context, resId)
    }

    override fun onDrawOver(canvas: Canvas, parent: RecyclerView, state: RecyclerView.State) {

        val left = parent.paddingLeft + paddingLeft
        val right = parent.width - parent.paddingRight - paddingRight
        val childCount = parent.childCount

        for (i in 0 until childCount) {
            val child = parent.getChildAt(i)
            val params = child.layoutParams as RecyclerView.LayoutParams
            val top = child.bottom + params.bottomMargin
            val bottom = top + (mDivider?.intrinsicHeight ?: 0)

            mDivider?.let {
                it.setBounds(left, top, right, bottom)
                it.draw(canvas)
            }

        }
    }
}