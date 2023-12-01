package com.tnmeta.torymeta.campus.ui

import android.app.Activity
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.util.Size
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.naver.maps.map.overlay.OverlayImage
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.databinding.CampusBoardSelectItemBinding
import com.tnmeta.torymeta.databinding.CampusBoardSelectViewBinding
import com.tnmeta.torymeta.model.dto.BoardDTO
import com.tnmeta.torymeta.model.dto.UniversityDTO
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setItemPadding
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.utils.Utilts
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getDimension
import com.tnmeta.torymeta.web.Web



/**
 * 게시판(우리끼리) 선택 화면
 */
class BoardSelectView(private val imageUrl : String, private val activity: Activity)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {

    companion object {
        private const val LIST_SPAN_COUNT = 2

        object SizeInfo {
            private val listWidth: Int by lazy {
                val screenSize = Utilts.instance.getScreenSize(ToryApplication.activity!!)
                var width = screenSize.x.toFloat()
                width -= ToryApplication.context!!.getDimension(R.dimen.common_padding_horizontal) * 2 // 화면 좌우 간격
                width.toInt()
            }

            private val itemWidth: Int by lazy {
                var width = listWidth
                width -= paddingX * (LIST_SPAN_COUNT -1) // 아이템 간격
                width / LIST_SPAN_COUNT
            }

            private val itemHeight: Int by lazy {
                (itemWidth * 0.261F).toInt()
            }

            val paddingX = ToryApplication.context!!.getDimension(R.dimen.campus_board_select_list_item_padding_horizontal).toInt()
            val paddingY = ToryApplication.context!!.getDimension(R.dimen.campus_board_select_list_item_padding_vertical).toInt()

            val itemSize: Size = Size(itemWidth, itemHeight)
            val padding: Size = Size(paddingX, paddingY)

        }
    }

    private val sizeInfo = SizeInfo
    lateinit var onClickListener: ((String) -> Unit)

    private val mImageUrl = imageUrl
    val viewBinding = CampusBoardSelectViewBinding.inflate(LayoutInflater.from(rootView.context), rootView, false)

    init {
        commonBottomSheetBinding.content.addView(viewBinding.root, 1)
        initList()
    }

    /**
     * 리스트 초기화
     */
    private fun initList() {
        val data = listOf(
            BoardDTO(Web.Url.COMMUNITY_MARKET, R.drawable.campus_board_icon_market, R.string.campus_board_title_market),
            BoardDTO(Web.Url.COMMUNITY_GATHER, R.drawable.campus_board_icon_gather, R.string.campus_board_title_gather),
            BoardDTO(Web.Url.COMMUNITY_TALK, R.drawable.campus_board_icon_talk, R.string.campus_board_title_talk),
            BoardDTO(Web.Url.COMMUNITY_HELP, R.drawable.campus_board_icon_help, R.string.campus_board_title_help),
        )

        viewBinding.boardListView.apply {
            layoutParams.apply {
                // this.height = SizeInfo.listSize.height
            }

            layoutManager = GridLayoutManager(rootView.context, LIST_SPAN_COUNT)
            adapter = ListAdapter(SizeInfo.itemSize, { data ->
                onClickListener(data.url)
                dismiss()
            }, data)

            setItemPadding(sizeInfo.paddingX, sizeInfo.paddingY)
        }

        Glide.with(rootView)
            .load(mImageUrl)
            .centerCrop()
            .into(viewBinding.imgLogo)

    }

    override fun show(animationDuration: Long) {
        super.show(animationDuration)
    }

    /**
     * 리스트 아이템 ViewHolder
     */
    class ItemViewHolder(val rootView: CampusBoardSelectItemBinding): RecyclerView.ViewHolder(rootView.root) {
        fun bind(data: BoardDTO) {
            rootView.apply {
                icon.setBackgroundResource(data.iconResId)
                title.text = root.context.getString(data.titleResId)
            }
        }
    }

    /**
     * 리스트 Adapter
     */
    class ListAdapter(private val itemSize: Size, val onClickItemListener: (BoardDTO) -> Unit, val datas: List<BoardDTO>): RecyclerView.Adapter<ItemViewHolder>() {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
            val viewBinding = CampusBoardSelectItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)

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