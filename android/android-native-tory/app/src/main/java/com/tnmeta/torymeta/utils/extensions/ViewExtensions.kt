package com.tnmeta.torymeta.utils.extensions

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.Rect
import android.graphics.drawable.Drawable
import android.view.View
import android.widget.ImageView
import androidx.annotation.ColorInt
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.BitmapTransformation
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.tnmeta.torymeta.databinding.UniversitySelectViewBinding

object ViewExtensions {
    fun View.setVisible(visible: Boolean, invisibleValue: Int = View.GONE) {
        visibility = if(visible) View.VISIBLE else invisibleValue
    }

    fun View.isVisible(): Boolean {
        return visibility == View.VISIBLE
    }

    fun ImageView.setImageUrl(url: String) {
        Glide.with(this)
            .load(url)
            .into(this)
    }

    fun ImageView.setImageUrl(url: String,
                              width: Int, height: Int, radius: Int,
                              transform: BitmapTransformation) {
        Glide.with(this).asBitmap()
            .load(url)
            .transform(transform, RoundedCorners(radius))
            .into(object: CustomTarget<Bitmap?>(width, height) {
                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap?>?) {
                    setImageBitmap(resource)
                }
                override fun onLoadCleared(placeholder: Drawable?) {}
            })
    }

    fun RecyclerView.setItemPadding(paddingX: Int, paddingY: Int, includeEdge: Boolean = false) {
        class Divider(val spanCount: Int): RecyclerView.ItemDecoration() {
            override fun getItemOffsets(outRect: Rect, view: View, parent: RecyclerView, state: RecyclerView.State) {
                val position = parent.getChildAdapterPosition(view)
                val column: Int = position % spanCount

                if( includeEdge ) {
                    outRect.left = paddingX - column * paddingX / spanCount
                    outRect.right = (column + 1) * paddingX / spanCount
                    if( position < spanCount ) {
                        outRect.top = paddingY
                    }
                    outRect.bottom = paddingY
                } else {
                    outRect.left = column * paddingX / spanCount
                    outRect.right = paddingX - (column + 1) * paddingX / spanCount
                    if (position >= spanCount) {
                        outRect.top = paddingY
                    }
                }
            }
        }

        var spanCount = 1

        if( layoutManager is GridLayoutManager ) {
            spanCount = (layoutManager as GridLayoutManager).spanCount
        }

        addItemDecoration(Divider(spanCount))
    }

    fun RecyclerView.setVerticalDivider(viewBiding : UniversitySelectViewBinding, dividerHeight: Float, paddingHorizontal: Float,
                                        @ColorInt color: Int) {
        class Divider(private val height: Float, private val paddingHorizontal: Float,
                      @ColorInt private val color: Int): RecyclerView.ItemDecoration() {

            private val paint = Paint()

            init {
                paint.color = color
            }

            override fun onDrawOver(c: Canvas, parent: RecyclerView, state: RecyclerView.State) {
                val left = parent.paddingStart + paddingHorizontal
                val right = parent.width - parent.paddingEnd - paddingHorizontal

                for (i in 0 until parent.childCount) {
                    val child = parent.getChildAt(i)
                    val params = child.layoutParams as RecyclerView.LayoutParams

                    val top = (child.bottom + params.bottomMargin).toFloat()
                    val bottom = top + height

                    c.drawRect(left, top, right, bottom, paint)
                }
            }
        }

        val divider = Divider(dividerHeight, paddingHorizontal, color)
        viewBiding.univListView.addItemDecoration(divider)

    }
//    @BindingAdapter(
//        value = ["dividerHeight", "dividerPadding", "dividerColor"],
//        requireAll = false
//    )
//    fun RecyclerView.setDivider(dividerHeight: Float?, dividerPadding: Float?, @ColorInt dividerColor: Int?) {
//        val decoration = CustomDecoration(
//            height = dividerHeight ?: 0f,
//            padding = dividerPadding ?: 0f,
//            color = dividerColor ?: Color.TRANSPARENT
//        )
//
//        addItemDecoration(decoration)
//    }
}