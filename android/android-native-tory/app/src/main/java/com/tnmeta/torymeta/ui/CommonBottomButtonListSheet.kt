package com.tnmeta.torymeta.ui

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.CommonBottomButtonListItemBinding
import com.tnmeta.torymeta.databinding.CommonBottomButtonListSheetBinding
import com.tnmeta.torymeta.model.ButtonData
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getDimension
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setItemPadding

/**
 * 버튼 목록이 노출되는 공통 하단 시트
 */
open class CommonBottomButtonListSheet(private val activity: Activity, private val datas: List<ButtonData>)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {



    lateinit var onClickListener: ((Any) -> Unit)

    val viewBinding = CommonBottomButtonListSheetBinding.inflate(LayoutInflater.from(rootView.context), rootView, false)

    init {
        commonBottomSheetBinding.content.addView(viewBinding.root)
        initButtonList()
    }

    private fun initButtonList() {
        viewBinding.apply {
            buttonListView.layoutManager = LinearLayoutManager(activity, RecyclerView.VERTICAL, false)
            buttonListView.adapter = ListAdapter(activity, datas,
                onClickItemListener = { data ->
                    onClickItem(data)
                })

            val padding = rootView.context.getDimension(R.dimen.common_bottom_btn_list_sheet_list_item_padding).toInt()
            buttonListView.setItemPadding(0, padding)
        }
    }

    protected open fun onClickItem(data: ButtonData) {
        onClickListener(data.type)
        dismiss()
    }

    /**
     * 리스트 아이템 ViewHolder
     */
    protected class ItemViewHolder(val rootView: CommonBottomButtonListItemBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(data: ButtonData) {
            rootView.apply {
                itemView.setBackgroundResource(data.backgroundResId)
                title.setText(data.titleResId)
                title.setTextColor(itemView.context.getColor(data.titleColorResId))
            }
        }
    }

    /**
     * 리스트 Adapter
     */
    protected class ListAdapter(val context: Context, val datas: List<ButtonData>,
                                val onClickItemListener: (ButtonData) -> Unit): RecyclerView.Adapter<ItemViewHolder>() {

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
            val viewBinding = CommonBottomButtonListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return ItemViewHolder(viewBinding)
        }

        override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
            val data = datas[position]
            holder.bind(data)
            holder.itemView.setOnClickListener {
                onClickItemListener(data)
            }
        }

        override fun getItemCount(): Int = datas.size
    }
}