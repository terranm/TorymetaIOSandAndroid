package com.tnmeta.torymeta.campus.ui

import android.app.Activity
import android.util.Size
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import com.tnmeta.torymeta.databinding.CampusVisitSelectItemBinding
import com.tnmeta.torymeta.databinding.CampusVisitSelectViewBinding
import com.tnmeta.torymeta.model.dto.UniversityDTO
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setImageUrl
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setItemPadding
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.utils.Utilts
import timber.log.Timber


/**
 * 캠퍼스 방문 > 캠퍼스 선택 UI
 */
class CampusSelectView(private val activity: Activity,
                       private val viewModel: CampusViewModel,
                       private val selectedCampusCode: String?)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {

    companion object {
        private const val LIST_SPAN_COUNT = 3

        fun getListWidth(): Float {
            val screenSize = Utilts.instance.getScreenSize(ToryApplication.activity!!)
            var width = screenSize.x.toFloat()
            width -= ToryApplication.activity!!.resources.getDimension(R.dimen.campus_visit_select_padding_horizontal) * 2 // 화면 좌우 간격
            return width
        }

        fun getListHeight(): Float {
            var height = getItemHeight() * 4F
            height += getItemPadding() * 3F
            height += 2 // 테두리
            return height
        }

        fun getItemWidth(): Float {
            var width = getListWidth()
            width -= getItemPadding() * (LIST_SPAN_COUNT -1) // 아이템 간격
            return width / LIST_SPAN_COUNT.toFloat()
        }

        fun getItemHeight() = getItemWidth() * 0.74F
        fun getItemPadding() = ToryApplication.activity!!.resources.getDimension(R.dimen.campus_visit_select_campus_item_padding)
    }

    object SizeInfo {
        val listSize: Size = Size(getListWidth().toInt(), getListHeight().toInt())
        val itemSize: Size = Size(getItemWidth().toInt(), getItemHeight().toInt())
        val itemPadding: Int = getItemPadding().toInt()

    }

    //val sizeInfo = SizeInfo
    var onSelected: ((UniversityDTO) -> Unit)? = null
    val viewBinding = CampusVisitSelectViewBinding.inflate(LayoutInflater.from(rootView.context), rootView, false)

    init {
        commonBottomSheetBinding.content.addView(viewBinding.root, 1)
        initCampusList()
    }

    /**
     * 리스트 초기화
     */
    private fun initCampusList() {
        try {
            val campusList = run {
                val list = viewModel.universityList.toMutableList()
                // 내 캠퍼스 삭제
                list.removeIf {
                    it.universityCode == viewModel.getMyCampus().universityCode
                }
                list
            }

            val adapter = ListAdapter(SizeInfo.itemSize, campusList)
            adapter.onClickItemListener = { data ->
                onSelected?.let { it -> it(data) }
                dismiss()
            }
            adapter.selectedCampusCode = selectedCampusCode

            viewBinding.campusListView.apply {
                this.adapter = adapter
                layoutParams.height = SizeInfo.listSize.height
                layoutManager = GridLayoutManager(rootView.context, LIST_SPAN_COUNT)
                setItemPadding(SizeInfo.itemPadding, SizeInfo.itemPadding)
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun show(animationDuration: Long) {
        super.show(animationDuration)
    }

    /**
     * 리스트 아이템 ViewHolder
     */
    class ItemViewHolder(val rootView: CampusVisitSelectItemBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(data: UniversityDTO) {
            try {
                rootView.apply {
                    icon.setImageUrl(if(data.imgUrl.isNullOrEmpty()) "" else data.imgUrl)
                    name.text = data.universityName
                }
            }catch (e : Exception){
                Timber.e(e.message)
            }
        }
    }

    /**
     * 리스트 Adapter
     */
    class ListAdapter(private val itemSize: Size, private val itemArray: List<UniversityDTO>): RecyclerView.Adapter<ItemViewHolder>() {
        lateinit var onClickItemListener: (UniversityDTO) -> Unit
        var selectedCampusCode: String? = null

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {

            val viewBinding = CampusVisitSelectItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            viewBinding.root.layoutParams.apply {
                width = itemSize.width
                height = itemSize.height
            }
            return ItemViewHolder(viewBinding)
        }

        override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
            val data = itemArray[position]
            holder.bind(data)

            holder.itemView.apply {
                setOnClickListener {
                    onClickItemListener(data)
                }

                /*
                if( data.universityCode == selectedCampusCode ) {
                    setBackgroundResource(R.drawable.common_corner_small_stroke_purple)
                } else {
                    setBackgroundResource(R.drawable.common_corner_small_stroke_gray_03)
                }
                 */
                setBackgroundResource(
                    if(data.universityCode == selectedCampusCode) R.drawable.common_corner_small_stroke_purple
                    else R.drawable.common_corner_small_stroke_gray_03
                )
            }
        }

        override fun getItemCount(): Int = itemArray.size
    }
}