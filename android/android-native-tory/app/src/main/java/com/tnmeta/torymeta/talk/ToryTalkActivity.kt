package com.tnmeta.torymeta.talk

import android.content.Intent
import android.os.Bundle
import android.util.Config
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.tabs.TabLayoutMediator
import com.tnmeta.torymeta.BuildConfig
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityToryTalkBinding
import com.tnmeta.torymeta.databinding.ToryTalkPageBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.ButtonData
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.dto.FriendDTO
import com.tnmeta.torymeta.model.param.ChannelsParam
import com.tnmeta.torymeta.talk.chatting.ChattingListHelper
import com.tnmeta.torymeta.talk.ui.FriendCellData
import com.tnmeta.torymeta.talk.ui.FriendListAdapter
import com.tnmeta.torymeta.talk.ui.FriendListDivider
import com.tnmeta.torymeta.ui.CommonBottomButtonListSheet
import com.tnmeta.torymeta.ui.CommonLoadingView
import com.tnmeta.torymeta.ui.recyclerview.BaseAdapter
import com.tnmeta.torymeta.ui.recyclerview.BaseViewHolder
import com.tnmeta.torymeta.utils.contacts.ContactsHelper
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber
import kotlin.collections.ArrayList

private typealias PageDataType = BaseAdapter<Any>

/**
 * 토리톡 메인 화면
 */
class ToryTalkActivity: BaseActivity(TransitionModeType.SLIDE_IN_RIGTH) {
    companion object {
        val TAG : String          = ToryTalkActivity::class.java.simpleName
    }

    private lateinit var friendListHelper: FriendListHelper
    private lateinit var chattingListHelper: ChattingListHelper

    private val chatListAdapter = FriendListAdapter(ArrayList<FriendCellData>())
    private lateinit var pagerAdapter: PagerAdapter

    private val viewBinding by viewBinding(ActivityToryTalkBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewBinding.apply {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, R.string.tory_talk_title)
            setTopBarBackButtonEnabled(viewBinding.topBar,true) {
                finish()
            }

            // 상단 > 더보기 클릭
            moreBtn.setOnClickListener {
                showMoreMenuSheet()
            }

            initFriendList()
            initChatList()
            initPager()

            // Step 1. 연락처를 가져옵니다
            getPhoneContacts { phoneList ->
                // Step 2. 친구 목록을 가져옵니다
                repository.getFriendMayKnowList(ApiMode.UIMode.ONLY_LOADING, phoneList)
                repository.getFriendRequestList(ApiMode.UIMode.NONE)
                repository.getFriendList(ApiMode.UIMode.ONLY_LOADING)
                repository.getFriendBlockList(ApiMode.UIMode.NONE)
            }

            getChatList("", 0, 50)
        }
    }

    /**
     * 친구 목록 > Cell 클릭
     */
    private fun onClickFriendListCell(cell: FriendCellData) {
        when( cell.cellType ) {
            // 검색
            FriendListCellType.SEARCH-> {
                friendListHelper.replaceSearchScene(FriendListType.NEW)
            }

            // 목록 상세
            FriendListCellType.LIST_TITLE-> {
                val listType = cell.data as FriendListType
                val list = repository.friendListMap.value!![listType]!!

                listLauncher.launch(FriendListActivity.createIntent(this, listType))

                /*
                if( list.isNotEmpty() ) {
                    listLauncher.launch(FriendListActivity.createIntent(this, listType))
                }
                 */
            }

            // 친구 상세
            FriendListCellType.FRIEND_CAMPUS,
            FriendListCellType.FRIEND_UNKNOWN_LOCATION-> {
                friendListHelper.showFriendDetailView(cell.data as FriendDTO)
            }

            else-> {

            }
        }
    }

    private val listLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == RESULT_OK ) {
        }
    }

    /**
     * 친구 목록을 업데이트합니다
     */
    private fun updateFriendList() {
        friendListHelper.updateData { datas ->
            datas.clear()

            // 검색
            datas.add(FriendCellData(FriendListCellType.SEARCH, ""))

            // 친구
            listOf(
                FriendListType.NEW,
                FriendListType.REQUEST,
                FriendListType.CAMPUS,
                FriendListType.UNKNOWN_LOCATION
            ).forEach { type ->
                datas.add(FriendCellData(FriendListCellType.LIST_TITLE, type))

                val cellType = FriendListCellType.toType(type)
                val list = repository.getCacheFriendDataList(type)

                list.forEach { data ->
                    datas.add(FriendCellData(cellType, data))
                }
            }
        }
    }

    /**
     * 연락처를 가져옵니다
     */
    private fun getPhoneContacts(onFinished: (List<String>) -> Unit) {
        if( !repository.myContactPhoneList.isNullOrEmpty() ) {
            onFinished(repository.myContactPhoneList!!)
            return
        }

        val loadingView = CommonLoadingView.createInRootView(this)
        loadingView.show(false, 500)

        // 연락처를 가져옵니다
        val contactsHelper = ContactsHelper(this)
        contactsHelper.onPermissionDenied = {
            finish()
        }
        contactsHelper.contacts.observe(this) { contacts ->
            // 번호 목록 생성
            val phoneList = mutableListOf<String>()

//            if (BuildConfig.DEBUG) {
//                phoneList.add("01087051693")
//                phoneList.add("01052400851")
//                phoneList.add("01050546370")
//            }

            contacts.forEach { contact ->
                contact.numbers.forEach {
                    var phoneNumber = it
                    phoneNumber = phoneNumber.replace("+82", "0")
                    phoneNumber = phoneNumber.replace("+82-", "0")
                    phoneNumber = phoneNumber.replace("-", "")

                    phoneList.add(phoneNumber)
                }
            }

            repository.myContactPhoneList = phoneList
            onFinished(phoneList)

            // 최초 1회만 받아옵니다
            contactsHelper.contacts.removeObservers(this)
            loadingView.dismiss()
        }
        contactsHelper.fetchContacts()
    }

    /**
     * 친구 목록 초기화
     */
    private fun initFriendList() {
        friendListHelper = FriendListHelper(this)
        friendListHelper.onClickCellListener = {
            onClickFriendListCell(it)
        }

        repository.friendListMap.observe(this) {
            updateFriendList()
        }
    }

    /**
     * 채팅 목록 초기화
     */
    private fun initChatList() {
        chattingListHelper = ChattingListHelper(this)

        chatListAdapter.onClickCellListener = { data ->

        }
    }

    /**
     * ViewPager 초기화
     */
    private fun initPager() = viewBinding.apply{
        /*
        pagerAdapter = PagerAdapter(listOf(friendListHelper.adapter, chatListAdapter) as List<PageDataType>)

        pager.apply {
            adapter = pagerAdapter
            isUserInputEnabled = false
        }

        tabs.apply {
            val titles = listOf(R.string.tory_talk_friend_list_title, R.string.tory_talk_chat_list_title)

            TabLayoutMediator(this, pager) { tab, position ->
                tab.text = getString(titles[position])
            }.attach()
        }
         */

        pagerAdapter = PagerAdapter(listOf(friendListHelper.adapter) as List<PageDataType>)

        pager.apply {
            adapter = pagerAdapter
            isUserInputEnabled = false
        }

        tabs.apply {
            val titles = listOf(R.string.tory_talk_friend_list_title)

            TabLayoutMediator(this, pager) { tab, position ->
                tab.text = getString(titles[position])
            }.attach()
        }
    }

    /**
     * 친구목록/채팅목록 ViewPager Adapter
     */
    class PagerAdapter(datas: List<PageDataType>): BaseAdapter<PageDataType>(datas) {
        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PagerViewHolder {
            val viewBinding = ToryTalkPageBinding.inflate(LayoutInflater.from(parent.context), parent, false).apply {
                listView.layoutManager = LinearLayoutManager(parent.context, RecyclerView.VERTICAL, false)
                listView.addItemDecoration(FriendListDivider())
            }

            return PagerViewHolder(viewBinding)
        }
    }

    /**
     * 친구목록/채팅목록 ViewHolder
     */
    class PagerViewHolder(val rootView: ToryTalkPageBinding): BaseViewHolder<PageDataType>(rootView.root) {
        override fun bind(adapter: PageDataType) {
            rootView.apply {
                listView.adapter = adapter
                adapter.notifyDataSetChanged()
            }
        }
    }

    /**
     * 더보기 메뉴 하단 시트 노출
     */
    private fun showMoreMenuSheet() {
        val buttons = listOf(
            ButtonData(
                FriendListType.BLOCK,
                R.drawable.common_corner_medium_white, R.string.friend_list_block, R.color.tory_red
            ),
            ButtonData(
                FriendListType.INVALID, R.drawable.common_corner_medium_purple, R.string.profile_change_sheet_btn_cancel, R.color.tory_white
            ),
        )

        val sheet = CommonBottomButtonListSheet(this, buttons)
        sheet.onClickListener = onClickListener@ {

            when(it as FriendListType) {
                FriendListType.BLOCK-> {
                    listLauncher.launch(FriendListActivity.createIntent(this, FriendListType.BLOCK))
                }
                else-> {
                }
            }

        }
        sheet.show()
    }

    private fun getChatList(query : String, page : Int, length : Int) = try {

        val params = BaseParam(ChannelsParam(query, page, length)).parameter
        Timber.d(" getChatList $params")
        repository.getChannels(params)
            .subscribeBy(onNext = {

                chattingListHelper.updateData(it.lists)

            }, onError = {
                Timber.d(it.message)
            })
    }catch (e : Exception){
        Timber.d(e.message)
    }


}