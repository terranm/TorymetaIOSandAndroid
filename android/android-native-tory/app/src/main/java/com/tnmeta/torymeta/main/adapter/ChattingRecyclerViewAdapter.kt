package com.tnmeta.torymeta.main.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.databinding.ChattingLoungeListItemBinding
import timber.log.Timber

class ChattingRecyclerViewAdapter(private val items : List<ChattingRoom>,
                                  val onItemViewClick : (ChattingRoom) -> Unit ) : RecyclerView.Adapter<ChattingRecyclerViewAdapter.RecycleViewHolder>(){

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =  RecycleViewHolder (
        ChattingLoungeListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: ChattingRecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = items!![position]
            holder.run {
                bind(dataInfo)
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: ChattingLoungeListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: ChattingRoom) {
            with(viewBinding) {
                item.run {
                    chattingTitle.text = title
                    chattingCreator.text = creatorName

                    lock.visibility = if(privateRoom) View.VISIBLE
                                        else View.GONE
                    headCount.text = String.format("%d/%d", clients, maxClients)

                    val imageUrl = image

                    Glide.with(root.context)
                        .load(imageUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(profile)


                    enter.isEnabled = if(clients < maxClients && !locked) {
                        enter.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                        true
                    }else {
                        enter.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                        false
                    }

                    enter.setOnClickListener {
                        onItemViewClick(item)
                    }
                }
            }
        }
    }
}