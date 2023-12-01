package com.tnmeta.torymeta.chattinglounge.adapter

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
import com.tnmeta.torymeta.chattinglounge.model.ChattingSortType
import com.tnmeta.torymeta.databinding.OpenedChattingLoungeListItemBinding
import com.tnmeta.torymeta.main.model.SeminarDto
import timber.log.Timber

class ChattingLoungeListViewAdapter(private val items : List<ChattingRoom>,
                                    val onItemViewClick: (ChattingRoom) -> Unit) : RecyclerView.Adapter<ChattingLoungeListViewAdapter.RecycleViewHolder>(){

    private var sortType = ChattingSortType.All

//    fun arrayReset() {
//        this.mSeminarArrayList.clear()
//    }
//    fun replaceItems(items: List<SeminarDto>) {
//        this.mSeminarArrayList.addAll(items)
//    }

    fun setSortType(sortType: ChattingSortType) {
        this.sortType = sortType
    }

    override fun getItemCount(): Int  {
        return when(sortType) {
            ChattingSortType.All         -> items.size
            ChattingSortType.Available   -> items.filter { !it.locked }.size
            ChattingSortType.Lock        -> items.filter {  it.locked }.size
            ChattingSortType.Open        -> items.filter { !it.privateRoom }.size
            ChattingSortType.Private     -> items.filter { it.privateRoom }.size
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =  RecycleViewHolder (
        OpenedChattingLoungeListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: ChattingLoungeListViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val itemValue = when (sortType) {
                ChattingSortType.All        -> items[position]
                ChattingSortType.Available  -> items.filter { !it.locked }[position]
                ChattingSortType.Lock       -> items.filter {  it.locked }[position]
                ChattingSortType.Open       -> items.filter { !it.privateRoom }[position]
                ChattingSortType.Private    -> items.filter {  it.privateRoom }[position]
            }
            holder.run {
                bind(itemValue)

            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: OpenedChattingLoungeListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
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