package com.tnmeta.torymeta.talk

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityFriendListBinding
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.dto.FriendDTO
import com.tnmeta.torymeta.talk.ui.FriendCellData
import com.tnmeta.torymeta.talk.ui.FriendListDivider

/**
 * 친구 목록 상세 화면
 */
class FriendListActivity: BaseActivity(TransitionModeType.SLIDE_IN_RIGTH) {
    companion object {
        val TAG : String = FriendListActivity::class.java.simpleName

        const val PARAM_TYPE = "type"

        fun createIntent(context: Context, type: FriendListType): Intent {
            return Intent(context, FriendListActivity::class.java).apply {
                putExtra(PARAM_TYPE, type.i)
            }
        }
    }

    val type: FriendListType by lazy {
        FriendListType.toType(intent.getIntExtra(PARAM_TYPE, FriendListType.INVALID.i))
    }

    lateinit var friendListHelper: FriendListHelper

    private val viewBinding by viewBinding(ActivityFriendListBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, FriendConstants.getTitle(this@FriendListActivity, type))
            setTopBarBackButtonEnabled(viewBinding.topBar,true) {
                finish()
            }

            searchBtn.setOnClickListener {
                friendListHelper.replaceSearchScene(type)
            }

            initList()
        }
    }

    /**
     * 친구 Cell 클릭
     */
    private fun onClickCell(cell: FriendCellData) {
        when( cell.cellType ) {
            // 친구 상세
            FriendListCellType.FRIEND_CAMPUS,
            FriendListCellType.FRIEND_UNKNOWN_LOCATION-> {
                friendListHelper.showFriendDetailView(cell.data as FriendDTO)
            }

            else-> {

            }
        }
    }

    /**
     * 친구 목록을 업데이트합니다
     */
    private fun updateFriendList() {
        friendListHelper.updateData { datas ->
            datas.clear()

            val cellType = FriendListCellType.toType(type)
            val list = repository.getCacheFriendDataList(type)

            list.forEach { data ->
                datas.add(FriendCellData(cellType, data))
            }
        }
    }

    /**
     * 목록 초기화
     */
    private fun initList() = viewBinding.apply{
        friendListHelper = FriendListHelper(this@FriendListActivity)
        friendListHelper.onClickCellListener = {
            onClickCell(it)
        }

        listView.apply {
            layoutManager = LinearLayoutManager(this@FriendListActivity, RecyclerView.VERTICAL, false)
            addItemDecoration(FriendListDivider())
            adapter = friendListHelper.adapter
        }


        repository.friendListMap.observe(this@FriendListActivity) {
            updateFriendList()
        }
    }
}