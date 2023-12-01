package com.tnmeta.torymeta.seminar.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.RoominfoListItemBinding
import com.tnmeta.torymeta.main.model.RoomInfoDto
import timber.log.Timber


class SeminarRoomViewAdapter(private val items : List<RoomInfoDto>,
                             val onItemClick: (RoomInfoDto, Int) -> Unit,
                             private var selectedPosition : Int) : RecyclerView.Adapter<SeminarRoomViewAdapter.RecycleViewHolder>()
{
    //var selectedPosition = selectedPosition

    fun setSelectPosition(position: Int) {
        this.selectedPosition = position
    }


    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = RecycleViewHolder (
        RoominfoListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )


    override fun onBindViewHolder(holder: SeminarRoomViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {

            val itemValue = items!![position]
            holder.run {
                bind(itemValue)

                itemView.setOnClickListener {

                    if(selectedPosition == position)
                        return@setOnClickListener

                    val prevPosition = selectedPosition
                    itemValue.isSelect = !itemValue.isSelect
                    selectedPosition = position
                    notifyItemChanged(selectedPosition)

                    if (prevPosition != -1 && selectedPosition != prevPosition) {
                        val itemInfo = items!![prevPosition]
                        itemInfo.isSelect = false
                        notifyItemChanged(prevPosition)
                    }

                    onItemClick(itemValue, selectedPosition)
                    //isEnableCheck(true)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: RoominfoListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: RoomInfoDto) {
            with(viewBinding) {
                item.run {
                    Glide.with(root.context)
                        .load(roomImageUrl)
                        .transform(CenterCrop(), RoundedCorners(34))
                        .into(imgThumbnail)
                    seminarRoomName.text = roomName

                    val imageResouce = if (item.isSelect) R.drawable.common_corner_round_purple_01
                                        else R.drawable.common_corner_round_white_01

                    thumbnailLayout.setBackgroundResource(imageResouce)
                }
            }
        }
    }
}