package com.tnmeta.torymeta.ui.recyclerview

import android.view.View
import androidx.recyclerview.widget.RecyclerView

/**
 * BaseAdapter
 */
abstract class BaseAdapter<DataType>: RecyclerView.Adapter<BaseViewHolder<DataType>> {
    val datas: List<DataType>
    var isCellClickable = true
    var onClickCellListener: ((DataType) -> Unit)? = null


    constructor(datas: List<DataType>) {
        this.datas = datas
    }

    override fun onBindViewHolder(holder: BaseViewHolder<DataType>, position: Int) {
        val data = datas[position]
        holder.bind(data)

        if( holder.itemView.isClickable ) {
            holder.itemView.setOnClickListener {
                onClickCell(holder)
            }
        }
    }

    override fun getItemCount(): Int = datas.size

    protected open fun initViewHolder(viewHolder: BaseViewHolder<DataType>) {
        val cell = viewHolder.itemView
        cell.isClickable = isCellClickable
    }

    protected open fun onClickCell(viewHolder: BaseViewHolder<DataType>) {
        onClickCellListener?.let {
            it(viewHolder.data!!)
        }
    }
}

/**
 * BaseViewHolder
 */
abstract class BaseViewHolder<DataType>(rootView: View) : RecyclerView.ViewHolder(rootView) {
    var data: DataType? = null

    open fun bind(data: DataType) {
        this.data = data
    }
}


