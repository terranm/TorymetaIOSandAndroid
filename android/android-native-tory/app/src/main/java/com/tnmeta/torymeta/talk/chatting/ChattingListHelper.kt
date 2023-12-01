package com.tnmeta.torymeta.talk.chatting

import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.model.dto.chatting.ListItem
import com.tnmeta.torymeta.talk.ui.FriendCellData
import com.tnmeta.torymeta.talk.ui.FriendListAdapter


class ChattingListHelper(val activity: BaseActivity)  {
    companion object {
        val TAG : String = ChattingListHelper::class.java.simpleName
    }

    private val repository: ToryRepository = activity.repository

    val datas = ArrayList<ListItem>()
    val adapter :  ChattingListAdapter = ChattingListAdapter(datas)

    init {
        initAdapter()
    }

    private fun initAdapter() {

    }


    fun updateData(item: List<ListItem>) {
        adapter.notifyDataSetChanged()
    }


}