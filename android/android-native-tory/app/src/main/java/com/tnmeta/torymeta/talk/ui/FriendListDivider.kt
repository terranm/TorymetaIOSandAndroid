package com.tnmeta.torymeta.talk.ui

import android.graphics.Rect
import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.talk.FriendListCellType
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getDimension

class FriendListDivider: RecyclerView.ItemDecoration() {
    override fun getItemOffsets(outRect: Rect, view: View, parent: RecyclerView, state: RecyclerView.State) {
        val position = parent.getChildAdapterPosition(view)
        outRect.top = 0

        if( position == 0 ) {
            return
        }

        val context = parent.context
        val topCellType = getCellType(parent.adapter!!, position-1)

        when(val type = getCellType(parent.adapter!!, position)) {
            FriendListCellType.LIST_TITLE-> {
                if( topCellType == FriendListCellType.SEARCH ) {
                    outRect.top = context.getDimension(R.dimen.friend_list_title_cell_between_search).toInt()
                }
                else if( topCellType.isFriendType() ) {
                    outRect.top = context.getDimension(R.dimen.friend_list_title_cell_between_friend).toInt()
                }
            }
            else-> {
                // Friend 4종
                if( type.isFriendType() ) {
                    if( topCellType == FriendListCellType.LIST_TITLE ) {
                        outRect.top = context.getDimension(R.dimen.friend_list_friend_cell_between_title).toInt()
                    }
                    else if( topCellType.isFriendType() ) {
                        outRect.top = context.getDimension(R.dimen.friend_list_friend_cell_between_friend).toInt()
                    }
                }
            }
        }
    }

    private fun getCellType(adapter: RecyclerView.Adapter<*>, position: Int): FriendListCellType {
        return FriendListCellType.toType(adapter.getItemViewType(position))
    }
}