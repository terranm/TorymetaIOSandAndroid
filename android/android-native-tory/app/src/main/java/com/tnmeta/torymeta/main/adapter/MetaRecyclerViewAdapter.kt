package com.tnmeta.torymeta.main.adapter


import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.databinding.MetaListItemBinding
import com.tnmeta.torymeta.main.model.RoomInfoDto
import timber.log.Timber

class MetaRecyclerViewAdapter(val datas : ArrayList<RoomInfoDto>,
                              val onItemClick: (RoomInfoDto) -> Unit,
                              val onItemButtonClick : (RoomInfoDto) -> Unit) : RecyclerView.Adapter<MetaRecyclerViewAdapter.RecycleViewHolder>(){

    override fun getItemCount(): Int = datas.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = RecycleViewHolder (
        MetaListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: MetaRecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = datas!![position]
            holder.run {
                bind(dataInfo)
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: MetaListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: RoomInfoDto) {
            with(viewBinding) {
                item.run {
                    metaTitle.text = roomName
                    Glide.with(root.context)
                        .load(roomImageUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(metaImage)

                    campusEnter.setOnClickListener {
                        onItemButtonClick(item)
                    }
                }
            }
        }
    }

}