package com.tnmeta.torymeta.campus.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.AvatarListItemBinding
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarModelingDTO
import timber.log.Timber

class AvatarViewAdapter(private var items : List<AvatarModelingDTO>,
                        val onItemClick : (AvatarModelingDTO, Int) -> Unit,
                        private var selectCaegoryPosition : Int ) : RecyclerView.Adapter<AvatarViewAdapter.RecycleViewHolder>(){

    fun setSelectPosition(position: Int) {
        this.selectCaegoryPosition = position
    }

    fun setItemsArray(items: List<AvatarModelingDTO>) {
        this.items = items
    }

    override fun getItemCount(): Int = items.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): AvatarViewAdapter.RecycleViewHolder {
        val binding = AvatarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return RecycleViewHolder(binding)
    }

    override fun onBindViewHolder(holder: AvatarViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
        try {
            val item = items!![position]
            holder.run {
                bind(item)

                itemView.setOnClickListener {

                    if(item.isDefaultSelect && item.isSelect) {
                        return@setOnClickListener
                    }

                    val prevPosition = selectCaegoryPosition
                    item.isSelect = !item.isSelect
                    selectCaegoryPosition = position
                    notifyItemChanged(selectCaegoryPosition)

                    //selectAvatar(item, position)
                    onItemClick(item, position)

                    if (prevPosition != -1 && selectCaegoryPosition != prevPosition) {
                        val itemInfo = items!![prevPosition]
                        itemInfo.isSelect = false
                        notifyItemChanged(prevPosition)
                    }
                }
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    inner class RecycleViewHolder(private var viewBinding: AvatarListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
        fun bind(item: AvatarModelingDTO) {
            with(viewBinding) {
                item.run {

                    val imageResouce = if (item.isSelect) R.drawable.avatar_select_background
                    else R.drawable.avatar_background

                    avatarLayout.setBackgroundResource(imageResouce)

                    txtPrice.text = String.format("%d", price)
                    Glide.with(root)
                        .load(imgUrl)
                        .centerCrop()
                        .into(viewBinding.avatar)

                    if(item.isOwned == 0) {
                        priceimage.visibility = View.VISIBLE
                        imgSelect.visibility = View.INVISIBLE
                    }else {
                        priceimage.visibility = View.INVISIBLE
                        imgSelect.visibility = View.VISIBLE
                    }
                }
            }
        }
    }

}