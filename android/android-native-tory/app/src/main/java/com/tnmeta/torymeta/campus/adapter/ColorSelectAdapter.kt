package com.tnmeta.torymeta.campus.adapter

import android.graphics.Color
import android.view.LayoutInflater
import android.view.ViewGroup
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.databinding.ColorListItemBinding
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarColorDTO
import com.tnmeta.torymeta.ui.recyclerview.BaseAdapter
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder
import timber.log.Timber


class ColorSelectAdapter(datas : List<AvatarColorDTO>)  : BaseAdapter<AvatarColorDTO>(datas) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {

        Timber.d("avatarColorArrayList " + datas.size)
        Timber.d("avatarColorArrayList $datas")


        val viewBinding = ColorListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        val holder = ViewHolder(viewBinding).apply {
            initViewHolder(this)
        }
        return holder
    }

    class ViewHolder(val rootView: ColorListItemBinding): BaseViewHolder<AvatarColorDTO>(rootView.root) {
        override fun bind(data: AvatarColorDTO) {
            super.bind(data)

            rootView.apply {
                //imgColor.setBackgroundColor(Color.parseColor(data.color_code))
            }
        }
    }
}