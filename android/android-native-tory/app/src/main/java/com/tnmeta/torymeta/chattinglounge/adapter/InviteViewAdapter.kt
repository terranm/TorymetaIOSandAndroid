package com.tnmeta.torymeta.chattinglounge.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.tnmeta.torymeta.databinding.InviteListItemBinding
import com.tnmeta.torymeta.model.MemberInfo

import timber.log.Timber


/**
 * InviteViewAdapter
 * @property items
 * @property onItemViewClick
 */
class InviteViewAdapter(private val items : List<MemberInfo>,
                        val onItemClick : (MemberInfo) -> Unit,
                        val onItemViewClick: (MemberInfo) -> Unit) : RecyclerView.Adapter<InviteViewAdapter.RecycleViewHolder>(){

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = RecycleViewHolder (
        InviteListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
    )

    override fun onBindViewHolder(holder: InviteViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val dataInfo = items!![position]
            holder.run {
                bind(dataInfo)
                itemView.setOnClickListener {
                    onItemClick(dataInfo)
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: InviteListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: MemberInfo) {
            with(viewBinding) {
                item.run {
                    inviteName.text = profileName
                    Glide.with(root.context)
                        .load(imgUrl)
                        .transform(CenterCrop(), RoundedCorners(16))
                        .into(profileImg)
                }

                addFriend.setOnClickListener {
                    onItemViewClick(item)
                }
            }
        }
    }
}