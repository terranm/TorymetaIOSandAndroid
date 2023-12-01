package com.tnmeta.torymeta.talk.ui

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.databinding.FriendListTitleCellBinding
import com.tnmeta.torymeta.databinding.ToryTalkFriendListSearchCellBinding
import com.tnmeta.torymeta.model.dto.FriendDTO
import com.tnmeta.torymeta.model.dto.OnFriendListener
import com.tnmeta.torymeta.talk.FriendConstants
import com.tnmeta.torymeta.talk.FriendListCellType
import com.tnmeta.torymeta.talk.FriendListType
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder
import com.tnmeta.torymeta.ui.recyclerview.SwipeAdapter
import com.tnmeta.torymeta.ui.recyclerview.SwipeViewHolder
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setImageUrl
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible

import kotlinx.android.synthetic.main.friend_list_friend_cell.view.*
import kotlinx.android.synthetic.main.friend_list_title_cell.view.*


data class FriendCellData (
    val cellType: FriendListCellType,
    val data: Any,
)

/**
 * 친구 목록 RecyclerView Adapter
 */
class FriendListAdapter(datas: List<FriendCellData>): SwipeAdapter<FriendCellData>(datas) {
    var onClickRequest: OnFriendListener? = null
    var onClickAccept: OnFriendListener? = null
    var onClickDelete: OnFriendListener? = null
    var onClickBlock: OnFriendListener? = null
    var onClickUnblock: OnFriendListener? = null

    init {
        // 스와이프로 고정될 범위
        swipeHelperCallback.clamp = ToryApplication.context!!.resources.getDimension(R.dimen.tory_talk_friend_list_cell_swipe_width)

        // 스와이프 돼야 할 View 지정
        swipeHelperCallback.onGetSwipeView = { viewHolder ->
            when( FriendListCellType.toType(viewHolder.itemViewType) ) {
                FriendListCellType.SEARCH ->            null
                FriendListCellType.LIST_TITLE->         null
                FriendListCellType.FRIEND_NEW->         null
                FriendListCellType.FRIEND_REQUEST->     null
                else -> {
                    viewHolder.itemView.swipeView
                }
            }
        }
    }

    override fun onClickCell(viewHolder: BaseViewHolder<FriendCellData>) {
        super.onClickCell(viewHolder)
    }

    override fun onAttachedToRecyclerView(recyclerView: RecyclerView) {
        super.onAttachedToRecyclerView(recyclerView)

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FriendListViewHolder {
        val cellType = FriendListCellType.toType(viewType)


        var layoutId = when( cellType ) {
            FriendListCellType.SEARCH->         R.layout.tory_talk_friend_list_search_cell
            FriendListCellType.LIST_TITLE->     R.layout.friend_list_title_cell
            else -> R.layout.friend_list_friend_cell
        }

        val view = LayoutInflater.from(parent.context).inflate(layoutId, parent, false)
        val holder = FriendListViewHolder(view).apply {
            initViewHolder(this)

            isSwipeEnabled = (cellType == FriendListCellType.FRIEND_CAMPUS ||
                              cellType == FriendListCellType.FRIEND_UNKNOWN_LOCATION)
        }


//        val viewBinding = if(cellType == FriendListCellType.SEARCH) {
//                                ToryTalkFriendListSearchCellBinding.inflate(LayoutInflater.from(parent.context), parent, false)
//                          }else {
//                                FriendListTitleCellBinding.inflate(LayoutInflater.from(parent.context), parent, false)
//                          }
//
//        val holder = FriendListViewHolder(viewBinding.root).apply {
//            initViewHolder(this)
//
//            isSwipeEnabled = (cellType == FriendListCellType.FRIEND_CAMPUS || cellType == FriendListCellType.FRIEND_UNKNOWN_LOCATION)
//        }


        return holder
    }

    override fun onBindViewHolder(holder: BaseViewHolder<FriendCellData>, position: Int) {
        super.onBindViewHolder(holder, position)

        val data = holder.data!!

        // Cell에 속한 메뉴 클릭 이벤트 처리
        when( data.cellType ) {
            FriendListCellType.SEARCH-> {

            }

            FriendListCellType.LIST_TITLE-> {
            }

            // 알 수도 있는 친구
            FriendListCellType.FRIEND_NEW-> {

                holder.itemView.requestBtn.setOnClickListener {
                    onClickRequest?.let {
                        it(data.data as FriendDTO)
                    }
                }
            }

            // 받은 친구 요청
            FriendListCellType.FRIEND_REQUEST-> {
                holder.itemView.acceptBtn.setOnClickListener {
                    onClickAccept?.let {
                        it(data.data as FriendDTO)
                    }
                }
            }

            // 친구
            FriendListCellType.FRIEND_CAMPUS,
            FriendListCellType.FRIEND_UNKNOWN_LOCATION-> {
                holder.itemView.deleteBtn.setOnClickListener {
                    onClickDelete?.let {
                        it(data.data as FriendDTO)
                    }

                    swipeHelperCallback.clearCurrentSwipe()
                }

                holder.itemView.blockBtn.setOnClickListener {
                    onClickBlock?.let {
                        it(data.data as FriendDTO)
                    }

                    swipeHelperCallback.clearCurrentSwipe()
                }
            }

            // 차단 리스트
            FriendListCellType.FRIEND_BLOCK-> {
                holder.itemView.unblockBtn.setOnClickListener {
                    onClickUnblock?.let {
                        it(data.data as FriendDTO)
                    }
                }
            }

            else -> {
            }
        }

        (holder as FriendListViewHolder).updateButtonClickable()
    }

    override fun getItemViewType(position: Int): Int = datas[position].cellType.i
}

/**
 * 친구 목록 View Holder
 */
class FriendListViewHolder(val rootView: View): SwipeViewHolder<FriendCellData>(rootView) {
    override fun setClamped(isClamped: Boolean) {
        super.setClamped(isClamped)
        updateButtonClickable()
    }

    fun updateButtonClickable() {
        val cellType = FriendListCellType.toType(itemViewType)

        if( cellType == FriendListCellType.FRIEND_CAMPUS ||
            cellType == FriendListCellType.FRIEND_UNKNOWN_LOCATION ) {
            rootView.deleteBtn.isClickable = isClamped
            rootView.blockBtn.isClickable = isClamped
        }
    }

    override fun bind(data: FriendCellData) {
        super.bind(data)


        rootView.apply {
            // 친구 Cell 초기화
            if( data.cellType.isFriendType() ) {

                listOf(acceptBtn, requestBtn, requestCompleteLayout, unblockBtn).forEach {
                    it.setVisible(false)
                }

                val friendData = data.data as FriendDTO
                profile.setImageUrl(friendData.imgUrl)
                name.text = friendData.profileName
            }

            // Binding
            when( data.cellType ) {
                FriendListCellType.SEARCH -> {

                }

                FriendListCellType.LIST_TITLE -> {
                    title.text = FriendConstants.getTitle(rootView.context, data.data as FriendListType)
                }

                // 알 수도 있는 친구
                FriendListCellType.FRIEND_NEW -> {
                    val friendData = data.data as FriendDTO
                    requestBtn.setVisible(!friendData.isFriendRequested)
                    requestCompleteLayout.setVisible(friendData.isFriendRequested)
                }

                // 받은 친구 요청
                FriendListCellType.FRIEND_REQUEST-> {
                    acceptBtn.setVisible(true)
                }

                // 친구
                FriendListCellType.FRIEND_CAMPUS,
                FriendListCellType.FRIEND_UNKNOWN_LOCATION-> {
                }

                // 차단 리스트
                FriendListCellType.FRIEND_BLOCK-> {
                    unblockBtn.setVisible(true)
                }

                else -> {
                }
            }
        }
    }
}