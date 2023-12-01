package com.tnmeta.torymeta.campus.ui

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.databinding.CampusTopMenuItemBinding
import com.tnmeta.torymeta.model.CampusTopMenuData
import com.tnmeta.torymeta.model.CampusTopMenuType


/**
 * 상단 메뉴 RecyclerView 홀더
 */
class CampusTopMenuViewHolder(val rootView: CampusTopMenuItemBinding): RecyclerView.ViewHolder(rootView.root) {
    fun bind(data: CampusTopMenuData) {
        rootView.apply {
            icon.setBackgroundResource(data.iconResId)
            title.text = rootView.root.context.getString(data.titleResId)
        }
    }
}

/**
 * 상단 메뉴 RecyclerView 어댑터
 */
class CampusTopMenuAdapter(val onClickItemListener: (CampusTopMenuType) -> Unit, val datas: Array<CampusTopMenuData>): RecyclerView.Adapter<CampusTopMenuViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CampusTopMenuViewHolder {
        val viewBinding = CampusTopMenuItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return CampusTopMenuViewHolder(viewBinding)
    }

    override fun onBindViewHolder(holder: CampusTopMenuViewHolder, position: Int) {
        val data = datas[position]
        holder.bind(data)
        holder.itemView.setOnClickListener {
            onClickItemListener(data.type)
        }
    }

    override fun getItemCount(): Int = datas.size
}