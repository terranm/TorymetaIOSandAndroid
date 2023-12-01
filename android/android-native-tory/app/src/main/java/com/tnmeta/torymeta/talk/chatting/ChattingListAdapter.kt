package com.tnmeta.torymeta.talk.chatting

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.databinding.ChattingChannelListItemBinding
import com.tnmeta.torymeta.model.dto.chatting.ListItem
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder
import com.tnmeta.torymeta.ui.recyclerview.SwipeAdapter
import com.tnmeta.torymeta.ui.recyclerview.SwipeViewHolder
import kotlinx.android.synthetic.main.friend_list_friend_cell.view.*


class ChattingListAdapter(datas: List<ListItem>) : SwipeAdapter<ListItem>(datas) {

    init {
        swipeHelperCallback.clamp = ToryApplication.context!!.resources.getDimension(R.dimen.tory_talk_friend_list_cell_swipe_width)

        swipeHelperCallback.onGetSwipeView = { viewHolder ->
            viewHolder.itemView.swipeView
        }

    }

    override fun onClickCell(viewHolder: BaseViewHolder<ListItem>) {
        super.onClickCell(viewHolder)
    }

    override fun onAttachedToRecyclerView(recyclerView: RecyclerView) {
        super.onAttachedToRecyclerView(recyclerView)

    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ChattingListListViewHolder {
        val view = ChattingChannelListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ChattingListListViewHolder(view.root)
    }

}

class ChattingListListViewHolder(val rootView: View): SwipeViewHolder<ListItem>(rootView) {
    override fun setClamped(isClamped: Boolean) {
        super.setClamped(isClamped)
        updateButtonClickable()
    }

    private fun updateButtonClickable() {

    }

    override fun bind(data: ListItem) {
        super.bind(data)

        rootView.apply {

        }
    }

}
