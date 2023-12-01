package com.tnmeta.torymeta.campus.list

import android.view.LayoutInflater
import android.view.ViewGroup
import com.tnmeta.torymeta.databinding.BbsNoticeItemBinding
import com.tnmeta.torymeta.model.dto.BBSNoticeDTO
import com.tnmeta.torymeta.ui.recyclerview.BaseAdapter
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder
import com.tnmeta.torymeta.utils.DateFormatter


class NoticeAdapter(datas : List<BBSNoticeDTO>) : BaseAdapter<BBSNoticeDTO>(datas) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val viewBinding = BbsNoticeItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        val holder = ViewHolder(viewBinding).apply {
            initViewHolder(this)
        }

        return holder
    }

    class ViewHolder(val rootView: BbsNoticeItemBinding): BaseViewHolder<BBSNoticeDTO>(rootView.root) {
        override fun bind(data: BBSNoticeDTO) {
            super.bind(data)

            rootView.apply {
                title.text = data.bbs_title
                val time  = DateFormatter.instance.fullDotted().parse(data.reg_dt)
                date.text = DateFormatter.instance.simpleDotted().format(time)
            }
        }
    }
}