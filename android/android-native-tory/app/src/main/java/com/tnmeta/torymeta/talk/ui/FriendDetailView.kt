package com.tnmeta.torymeta.talk.ui

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.recyclerview.widget.GridLayoutManager
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.databinding.FriendDetailNftCellBinding
import com.tnmeta.torymeta.databinding.FriendDetailViewBinding
import com.tnmeta.torymeta.model.dto.FriendDTO
import com.tnmeta.torymeta.model.dto.NFTCollectionDTO
import com.tnmeta.torymeta.ui.CommonBottomSheet
import com.tnmeta.torymeta.ui.recyclerview.BaseAdapter
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getContentView
import com.tnmeta.torymeta.utils.extensions.ContextExtensions.getDimension
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setImageUrl
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setItemPadding
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible
import com.tnmeta.torymeta.web.ToryWebActivity
import com.tnmeta.torymeta.web.Web
import io.reactivex.rxjava3.kotlin.subscribeBy


class FriendDetailView(private val activity: Activity, private val friendData: FriendDTO, private val repository: ToryRepository)
    : CommonBottomSheet(activity.getContentView() as ViewGroup) {
    companion object {
        private const val ListSpanCount = 3


        object ListSizeInfo {
            // val listSize: Size
            // val cellSize: Size
            val cellPadding: Int

            init {
                cellPadding = ToryApplication.activity!!.resources.getDimension(R.dimen.friend_detail_nft_cell_padding).toInt()
            }
        }
    }


    lateinit var onClickListener: ((Any) -> Unit)

    val viewBinding = FriendDetailViewBinding.inflate(LayoutInflater.from(rootView.context), rootView, false)
    init {

        viewBinding.apply {
            nickname.text = friendData.profileName
            Glide.with(rootView)
                .load(friendData.imgUrl)
                .circleCrop()
                .into(profileImg)

            chatBtn.visibility = View.VISIBLE
        }

        commonBottomSheetBinding.content.addView(viewBinding.root)

        initLocationToggle()
        initBottomButton(
            onClickItemListener = { data ->
                onClickListener(data)
                dismiss()
            })

        repository.getNFTCollectionList(ApiMode.UIMode.ONLY_LOADING, friendData.memberId,1, 6)
            .subscribeBy(onNext = { it ->
                initNFTList(it.data)
            }, onError = {})
    }

    private fun initLocationToggle() = viewBinding.apply {
        val updateToggleImage: (Boolean)-> Unit = { isBlocked ->
            if( isBlocked ) {
                locationToggleBtn.setBackgroundResource(R.drawable.campus_map_btn_location_off)
            } else {
                locationToggleBtn.setBackgroundResource(R.drawable.campus_map_btn_location_on)
            }
        }

        updateToggleImage(friendData.isLocationBlocked)

        locationToggleBtn.setOnClickListener {
            if( friendData.isLocationBlocked ) {
                // unblock
                repository.locationUnblockFriend(ApiMode.UIMode.ONLY_LOADING, friendData.memberId)
                    .subscribeBy(onNext = { it ->
                        if( it.isSucceed ) {
                            friendData.isLocationBlocked = false
                            updateToggleImage(false)
                        }
                    }, onError = {})
            } else {
                // block
                repository.locationBlockFriend(ApiMode.UIMode.ONLY_LOADING, friendData.memberId)
                    .subscribeBy(onNext = { it ->
                        if( it.isSucceed ) {
                            friendData.isLocationBlocked = true
                            updateToggleImage(true)
                        }
                    }, onError = {})
            }
        }
    }

    /**
     * 하단 버튼 초기화
     */
    private fun initBottomButton(onClickItemListener: (Any) -> Unit) = viewBinding.apply{
        // 채팅하기 클릭
        chatBtn.setOnClickListener {
            onClickItemListener(R.id.chatBtn)
        }

        // 친구 번호 있음
        if( friendData.phoneNum != null ) {
            // 전화하기 클릭
            callBtn.setOnClickListener {
                try {
                    Intent(Intent.ACTION_DIAL, Uri.parse("tel:${friendData.phoneNum}")).run {
                    activity.startActivity(this)
                }

                } catch(e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        // 친구 번호 없음
        else {
            // 전화하기 숨김
            callBtn.setVisible(false)

            // 채팅하기 버튼 영역 확대
            val lp = chatBtn.layoutParams as ConstraintLayout.LayoutParams
            lp.apply {
                width = 0
                leftToLeft = btnLayout.id
            }
        }
    }

    /**
     * NFT 리스트 초기화
     */
    private fun initNFTList(datas: List<NFTCollectionDTO>) = viewBinding.apply{
        if( datas.isEmpty() ) {
            return@apply
        }

        nftListEmptyView.setVisible(false)

        val adapter = NFTListAdapter(datas)

        // Cell 클릭 시 상세 화면으로 이동
        adapter.onClickCellListener = { data ->
            val loginToken = repository.getLoginToken()
            val bcToken = repository.getBCToken()

            //val i = ToryWebActivity.createIntent(activity, Web.Url.getNFTDetailUrl(loginToken, bcToken, data))
            //activity.startActivity(i)

            ToryWebActivity.createIntent(activity, Web.Url.getNFTDetailUrl(loginToken, bcToken, data)).run {
                activity.startActivity(this)
            }

        }

        // RecyclerView 초기화
        nftListView.apply {
            setVisible(true)

            this.adapter = adapter
            layoutManager = GridLayoutManager(rootView.context, ListSpanCount)

            val itemPadding = context.getDimension(R.dimen.friend_detail_nft_cell_padding).toInt()
            setItemPadding(itemPadding, itemPadding)
        }
    }

    class NFTListAdapter(datas: List<NFTCollectionDTO>): BaseAdapter<NFTCollectionDTO>(datas) {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BaseViewHolder<NFTCollectionDTO> {
            val viewBinding = FriendDetailNftCellBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            val holder = NFTViewHolder(viewBinding).apply {
                initViewHolder(this)
            }

            return holder
        }
    }

    class NFTViewHolder(val rootView: FriendDetailNftCellBinding): BaseViewHolder<NFTCollectionDTO>(rootView.root) {
        override fun bind(data: NFTCollectionDTO) {
            super.bind(data)

            rootView.apply {
                // Glide.with(rootView).load(data.imageURL).centerCrop().into(img)
                val lp = itemView.layoutParams
                val radius = itemView.resources.getDimension(R.dimen.common_corner_radius_small).toInt()
                img.setImageUrl(data.imageURL, lp.width, lp.height, radius, CenterCrop())
            }
        }
    }
}