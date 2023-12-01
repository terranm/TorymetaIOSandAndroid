package com.tnmeta.torymeta.main.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.GranularRoundedCorners
import com.tnmeta.torymeta.databinding.EventPageItemBinding
import com.tnmeta.torymeta.model.dto.EventDTO
import com.tnmeta.torymeta.model.dto.EventListDTO
import timber.log.Timber

class EventPagerAdapter(val pageData: ArrayList<EventListDTO>,
                        val onItemViewClick: (EventListDTO) -> Unit) : RecyclerView.Adapter<EventPagerAdapter.PagerViewHolder>() {

    override fun getItemCount(): Int = pageData.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = PagerViewHolder (
        EventPageItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: PagerViewHolder, position: Int) {
        holder.apply {
            bind(pageData[position])
            itemView.setOnClickListener {
                onItemViewClick(pageData[position])
            }
        }
    }

    inner class PagerViewHolder(val rootView: EventPageItemBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(data: EventListDTO) = try {
            rootView.apply {

                Glide.with(rootView.root)
                    .load(data.bannerImageUrl)
                    .transform(CenterCrop(),  GranularRoundedCorners(32.0f, 32.0f, 32.0f, 32.0f))
                    //.transform(GranularRoundedCorners(32.0f, 32.0f, 32.0f, 32.0f))
                    .into(eventImage)
            }
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }
}