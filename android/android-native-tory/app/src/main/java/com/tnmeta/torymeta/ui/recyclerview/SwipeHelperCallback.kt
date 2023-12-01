package com.tnmeta.torymeta.ui.recyclerview

import android.graphics.Canvas
import android.view.View
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView
import kotlin.math.max
import kotlin.math.min

/**
 * SwipeHelperCallback
 * ViewHolder가 SwipeViewHolder가 아니면 itemView의 tag로 고정 여부(isClamped)를 관리합니다
 */
class SwipeHelperCallback: ItemTouchHelper.Callback() {
    var recyclerView: RecyclerView? = null
    var onGetSwipeView: ((RecyclerView.ViewHolder) -> View?)? = null

    var currentPosition: Int? = null
    var previousPosition: Int? = null

    var clamp = 0f
    private var currentDx = 0f
    private var prevOriginDx = 0f // 직전에 발생한 원본 dX 값

    init {
    }

    override fun getMovementFlags(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder): Int {
        return makeMovementFlags(0, ItemTouchHelper.LEFT or ItemTouchHelper.RIGHT)
    }

    override fun onMove(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder, target: RecyclerView.ViewHolder) = false
    override fun onSwiped(viewHolder: RecyclerView.ViewHolder, direction: Int) {}

    /**
     * 인터렉션 종료
     */
    override fun clearView(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder) {
        currentDx = 0f
        previousPosition = viewHolder.adapterPosition
        getDefaultUIUtil().clearView(getView(viewHolder))
    }

    /**
     * 인터렉션 진행
     */
    override fun onSelectedChanged(viewHolder: RecyclerView.ViewHolder?, actionState: Int) {
        viewHolder?.let {
            currentPosition = viewHolder.adapterPosition
            getDefaultUIUtil().onSelected(getView(it))

            // 이전 스와이프 클리어
            if( currentPosition != previousPosition ) {
                clearPreviousSwipe()
            }
        }
    }

    override fun onChildDraw(c: Canvas, recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder, dX: Float, dY: Float,
                             actionState: Int, isCurrentlyActive: Boolean) {
        if( actionState != ItemTouchHelper.ACTION_STATE_SWIPE ) {
            return
        }

        // 무슨 조건인지 모르겠다
//        if( currentPosition != null && viewHolder != getViewHolder(currentPosition!!) ) {
//            return
//        }

        (viewHolder as? SwipeViewHolder<*>)?.let {
            if( !it.isSwipeEnabled ) {
                return
            }
        }

        // Swipe
        val view = getView(viewHolder) ?: return
        val isClamped = isClamped(viewHolder)

        // getView(viewHolder).animate().translationX(-clamp).setDuration(100L).start() // 애니메이션 참고용

        var newX = if( isClamped ) {
            if( isCurrentlyActive ) {
                dX - clamp
            } else {
                -clamp
            }
        } else {
            dX
            /*
            if( currentDx < 0f && dX > 0f ) {
                val diff = dX - prevOriginDx
                currentDx - diff
            } else {
                dX
            }
            */
        }
        newX = max(-clamp, newX)
        newX = min(0f, newX)

        currentDx = newX
        // Log.i("d1", "${if(isClamped) "isClamped" else ""} ${if(isCurrentlyActive) "isCurrentlyActive" else ""} final dX: $newX origin dX: $dX")

        getDefaultUIUtil().onDraw(c, recyclerView, view, newX, dY, actionState, isCurrentlyActive)

        prevOriginDx = dX
    }

    fun getViewHolder(index: Int): RecyclerView.ViewHolder? {
        val recyclerView = this.recyclerView ?: return null
        return recyclerView.findViewHolderForAdapterPosition(index)
    }

    fun getView(viewHolder: RecyclerView.ViewHolder): View? {
        onGetSwipeView?.let { listener ->
            listener(viewHolder)?.let { view ->
                return view
            }
        }

        return viewHolder.itemView
    }

    protected fun setClamped(viewHolder: RecyclerView.ViewHolder, isClamped: Boolean) {
        val swipeViewHolder = viewHolder as? SwipeViewHolder<*>

        if( swipeViewHolder != null ) {
            swipeViewHolder.setClamped(isClamped)
        } else {
            viewHolder.itemView.tag = isClamped
        }
    }

    protected fun isClamped(viewHolder: RecyclerView.ViewHolder): Boolean {
        val swipeViewHolder = viewHolder as? SwipeViewHolder<*>

        if( swipeViewHolder != null ) {
            return swipeViewHolder.isClamped
        } else {
            return viewHolder.itemView.tag as? Boolean ?: false
        }
    }

    override fun getSwipeEscapeVelocity(defaultValue: Float): Float {
        // 스와이프 후 Escape 방지
        return defaultValue * 10
    }

    override fun getSwipeThreshold(viewHolder: RecyclerView.ViewHolder): Float {
        // update clamped
        val isClamped = isClamped(viewHolder)
        setClamped(viewHolder, !isClamped && currentDx <= -clamp)

        // 스와이프 후 Escape 방지
        return 2f
    }

    /**
     * 스와이프 클리어
     */
    fun clearSwipe() {
        val recyclerView = this.recyclerView ?: return
        val adapter = recyclerView.adapter ?: return

        for( i in 0 until adapter.itemCount ) {
            clearSwipe(i)
        }
    }

    fun clearCurrentSwipe() {
        currentPosition?.let {
            clearSwipe(it)
        }
    }

    fun clearPreviousSwipe() {
        previousPosition?.let {
            clearSwipe(it)
        }
    }

    fun clearSwipe(index: Int) {
        val recyclerView = this.recyclerView ?: return
        val viewHolder = recyclerView.findViewHolderForAdapterPosition(index) ?: return

        clearSwipe(viewHolder)
    }

    fun clearSwipe(viewHolder: RecyclerView.ViewHolder) {
        getView(viewHolder)?.let {
            // it.translationX = 0f
            it.animate().x(0f).setDuration(100L).start()
        }
        setClamped(viewHolder, false)
    }
}