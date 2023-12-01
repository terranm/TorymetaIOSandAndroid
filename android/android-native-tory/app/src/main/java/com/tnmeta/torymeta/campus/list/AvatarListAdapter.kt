package com.tnmeta.torymeta.campus.list

import android.view.LayoutInflater
import android.view.ViewGroup
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.api.Api
import com.tnmeta.torymeta.databinding.AvatarListItemBinding
import com.tnmeta.torymeta.model.dto.myAvatar.WholeModelDTO
import com.tnmeta.torymeta.ui.recyclerview.BaseAdapter
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder



class AvatarListAdapter(datas : List<WholeModelDTO>) : BaseAdapter<WholeModelDTO>(datas) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val viewBinding = AvatarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        val holder = ViewHolder(viewBinding).apply {
            initViewHolder(this)
        }

        viewBinding.avatar.setOnClickListener {
            onClickCell(holder)
        }

        return holder
    }

    class ViewHolder(val rootView: AvatarListItemBinding): BaseViewHolder<WholeModelDTO>(rootView.root) {
        override fun bind(data: WholeModelDTO) {
            super.bind(data)

            rootView.apply {
                val url = Api.ImageUrl.BASE + "/" +
                          Api.ImageUrl.AVATAR_WHOLE_MODELING + "/" +
                          String.format("%s_%d.png", data.groupCode, data.id)
                Glide.with(rootView.root)
                    .load(url)
                    .into(rootView.avatar)
            }
        }
    }
}