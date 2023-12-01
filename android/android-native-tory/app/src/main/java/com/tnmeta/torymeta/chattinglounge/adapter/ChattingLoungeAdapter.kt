package com.tnmeta.torymeta.chattinglounge.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.databinding.BbsNoticeItemBinding
import com.tnmeta.torymeta.databinding.ChattingLoungeListItemBinding
import com.tnmeta.torymeta.main.model.ChattingLoungeDto
import com.tnmeta.torymeta.model.dto.BBSNoticeDTO
import com.tnmeta.torymeta.ui.recyclerview.BaseAdapter
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder

class ChattingLoungeAdapter(datas : List<ChattingRoom>)  : BaseAdapter<ChattingRoom>(datas){

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val viewBinding = ChattingLoungeListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        val holder = ViewHolder(viewBinding).apply {
            initViewHolder(this)
        }

        return holder
    }

    class ViewHolder(val rootView: ChattingLoungeListItemBinding): BaseViewHolder<ChattingRoom>(rootView.root) {
        override fun bind(data: ChattingRoom) {
            super.bind(data)

            rootView.apply {
                /*
                chattingTitle.text = data.title
                chattingCreator.text = data.creator
                lock.visibility = if(!data.password) View.INVISIBLE
                                        else View.VISIBLE

                headCount.text = String.format("%d/%d", data.chatting_count, data.chatting_max_count)
                 */
            }
        }
    }
}