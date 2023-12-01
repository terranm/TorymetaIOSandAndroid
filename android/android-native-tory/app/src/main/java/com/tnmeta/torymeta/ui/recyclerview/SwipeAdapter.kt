package com.tnmeta.torymeta.ui.recyclerview

import android.view.View
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView

/**
 * SwipeAdapter
 */
abstract class SwipeAdapter<DataType>(datas: List<DataType>): BaseAdapter<DataType>(datas) {
    lateinit var recyclerView: RecyclerView
    val swipeHelperCallback = SwipeHelperCallback()

    init {
    }

    override fun onAttachedToRecyclerView(recyclerView: RecyclerView) {
        super.onAttachedToRecyclerView(recyclerView)
        this.recyclerView = recyclerView

        recyclerView.apply {
            // ItemTouchHelper 추가
            swipeHelperCallback.recyclerView = recyclerView

            val itemTouchHelper = ItemTouchHelper(swipeHelperCallback)
            itemTouchHelper.attachToRecyclerView(recyclerView)

            // 리스트 스크롤 시 현재 스와이프 클리어
            addOnScrollListener(object: RecyclerView.OnScrollListener() {
                override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                    if( newState == RecyclerView.SCROLL_STATE_DRAGGING ) {
                        // Log.i("d1", "RecyclerView 스크롤 시작")
                        swipeHelperCallback.clearCurrentSwipe()
                    }
                }

                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    // Log.i("d1", "RecyclerView onScrolled: ${dy}")
                }
            })
        }
    }

    /**
     * Cell 클릭
     */
    override fun onClickCell(viewHolder: BaseViewHolder<DataType>) {
        val swipeViewHolder = viewHolder as? SwipeViewHolder
        swipeViewHolder?.let {
            // 뷰가 고정되지 않았을 때만 super 호출
            if( !it.isSwipeEnabled || !it.isClamped ) {
                super.onClickCell(viewHolder)
            }
        }

        // Cell 클릭 시 현재 스와이프 클리어
        swipeHelperCallback.clearCurrentSwipe()
    }
}

/**
 * SwipeViewHolder
 */
abstract class SwipeViewHolder<DataType>(rootView: View): BaseViewHolder<DataType>(rootView) {
    var isSwipeEnabled = true
    var isClamped = false
        private set

    open fun setClamped(isClamped: Boolean) {
        this.isClamped = isClamped
    }
}


