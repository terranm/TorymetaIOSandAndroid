package com.tnmeta.torymeta.utils

import android.graphics.Rect
import android.view.View
import androidx.recyclerview.widget.RecyclerView

/**
 * direct
 * left = 0
 * top = 1
 * right = 2
 * bottom = 3
 */
class Divider(private val padding: Int, private val direct : Int): RecyclerView.ItemDecoration() {
    override fun getItemOffsets(outRect: Rect, view: View, parent: RecyclerView, state: RecyclerView.State) {
        super.getItemOffsets(outRect, view, parent, state)

        val position = parent.getChildAdapterPosition(view)
        if( position > 0 ) {

            when(direct) {
                0 -> outRect.left = padding
                1 -> outRect.top = padding
            }

        }
    }
}