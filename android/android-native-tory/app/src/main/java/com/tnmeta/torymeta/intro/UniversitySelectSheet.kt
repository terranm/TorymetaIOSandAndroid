package com.tnmeta.torymeta.intro

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.UniversitySelectItemBinding
import com.tnmeta.torymeta.databinding.UniversitySelectViewBinding
import com.tnmeta.torymeta.model.dto.UniversityDTO
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getDimension
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVerticalDivider
import timber.log.Timber


open class UniversitySelectSheet(private val activity: Activity, private val univertyArray: List<UniversityDTO>)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {

    lateinit var onClickListener: ((UniversityDTO) -> Unit)

    private val universitySelectViewBinding = UniversitySelectViewBinding.inflate(LayoutInflater.from(rootView.context), rootView, false)

    init {
        commonBottomSheetBinding.content.addView(universitySelectViewBinding.root)
        initList()
    }

    private fun initList() {

        universitySelectViewBinding.apply {
            if(univertyArray.isNotEmpty()) {
                univListView.apply {
                    layoutManager = LinearLayoutManager(activity, RecyclerView.VERTICAL, false)
                    adapter = ListAdapter(activity, univertyArray,
                        onClickItemListener = { data ->
                            onClickItem(data)
                        }
                    )

                    setVerticalDivider(
                        universitySelectViewBinding,
                        activity.getDimension(R.dimen.common_line_border),
                        activity.getDimension(R.dimen.common_padding_horizontal),
                        activity.getColor(R.color.tory_gray_04)
                    )
                }
            }
        }
    }

    protected open fun onClickItem(data: UniversityDTO) {
        onClickListener(data)
        dismiss()
    }

    /**
     * 리스트 아이템 ViewHolder
     */
    protected class ItemViewHolder(val rootView: UniversitySelectItemBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(data: UniversityDTO) {
            rootView.apply {
                name.text = data.universityName
            }
        }
    }

    /**
     * 리스트 Adapter
     */
    protected class ListAdapter(val context: Context, val datas: List<UniversityDTO>,
                                val onClickItemListener: (UniversityDTO) -> Unit): RecyclerView.Adapter<ItemViewHolder>() {

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
            val viewBinding = UniversitySelectItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return ItemViewHolder(viewBinding)
        }

        override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
            try {
                val data = datas[position]
                holder.apply {
                    bind(data)
                    itemView.setOnClickListener {
                        onClickItemListener(data)
                    }
                }
            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        override fun getItemCount(): Int = datas.size
    }



}