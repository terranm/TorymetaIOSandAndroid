package com.tnmeta.torymeta.chattinglounge

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.core.content.ContextCompat
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.chattinglounge.adapter.ChattingLoungeListViewAdapter
import com.tnmeta.torymeta.chattinglounge.dialog.ChattingPasswordDialog
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.chattinglounge.model.ChattingSortType
import com.tnmeta.torymeta.chattinglounge.model.param.ChattingRoomListParam
import com.tnmeta.torymeta.chattinglounge.viewmodel.ChattingLougeListViewModel
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ActivityChattingLougeListBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.main.MainFragmentDirections
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.chatting.JoinChat
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


/**
 * ChattingLougeListActivity
 */
class ChattingLougeListActivity : BaseActivity(), View.OnClickListener {

    companion object {
        val TAG: String = ChattingLougeListActivity::class.java.simpleName

        fun createIntent(context: Context): Intent {
            return Intent(context, ChattingLougeListActivity::class.java)
        }
    }

    private val viewBinding by viewBinding(ActivityChattingLougeListBinding::inflate)
    private lateinit var viewModel: ChattingLougeListViewModel

    private val mChattingArrayList = ArrayList<ChattingRoom>()
    private lateinit var mChattingAdapter : ChattingLoungeListViewAdapter

    private var sortType = ChattingSortType.All

    /**
     * onCreate
     * @param savedInstanceState
     */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            viewModel = ViewModelProvider(this@ChattingLougeListActivity)[ChattingLougeListViewModel::class.java]

            mChattingAdapter = ChattingLoungeListViewAdapter(
                items = mChattingArrayList,
                onItemViewClick = { chattingRoom ->

                    if(chattingRoom.privateRoom) {
                        ChattingPasswordDialog.Builder(this@ChattingLougeListActivity, chattingRoom.password).apply {
                            setOnEnterClick {
                                val values = JoinChat(tableId = chattingRoom.tableId)
                                sendNativeUnityMessage(type = ToryMetaMessageType.JoinChat, valueParam = values)
                                finish()
                            }
                            show()
                        }

                    }else {
                        val values = JoinChat(tableId = chattingRoom.tableId)
                        sendNativeUnityMessage(type = ToryMetaMessageType.JoinChat, valueParam = values)
                        finish()
                    }

                }
            )

            chattingRecyclerView.apply {
                layoutManager = LinearLayoutManager(this@ChattingLougeListActivity)
                setDivider(R.drawable.menu_view_divider)
                adapter = mChattingAdapter
            }

            viewModel.apply {
                liveChattingList.observe(this@ChattingLougeListActivity) {list ->
                    mChattingArrayList.apply {
                        clear()
                        addAll(list)
                    }

                    if(mChattingArrayList.isEmpty()) {
                        emptyView.visibility = View.VISIBLE
                        chattingRecyclerView.visibility = View.GONE
                    }else {
                        emptyView.visibility = View.GONE
                        chattingRecyclerView.visibility = View.VISIBLE
                    }

                    mChattingAdapter.notifyDataSetChanged()
                }
            }

            radioGroup.setOnCheckedChangeListener { _, checkedId ->
                when(checkedId) {
                    R.id.radio_total -> initSortButton(ChattingSortType.All)

                    R.id.radio_available -> initSortButton(ChattingSortType.Available)

                    R.id.radio_open -> initSortButton(ChattingSortType.Open)

                    R.id.radio_private -> initSortButton(ChattingSortType.Private)
                }
            }
        }
    }


    /**
     * onResume
     */
    override fun onResume() {
        super.onResume()
        setFullScreen()
        viewModel.apply {
            val params = BaseParam(ChattingRoomListParam(Constants.ChatLounge, 40)).parameter
            getChattingList(params)
        }
    }


    /**
     * onClick
     * @param view
     */
    override fun onClick(view: View) {
        when(view.id) {
            R.id.close -> finish()
        }
    }


    /**
     * initSortButton
     * @param type
     */
    private fun initSortButton(type : ChattingSortType) = try {
        Timber.tag(TAG).d("initSortButton $type ")
        sortType = type

        viewBinding.apply {

            val textArray = arrayOf(txtTotal, txtAvailable, txtlock, txtOpen, txtPrivate)
            textArray.forEach {
                it.setTextColor(ContextCompat.getColor(this@ChattingLougeListActivity,  R.color.tory_gray_04))
            }

            textArray[type.ordinal].apply {
                setTextColor(ContextCompat.getColor(this@ChattingLougeListActivity,  R.color.tory_purple))
            }

            if(mChattingArrayList.isNotEmpty()) {
                mChattingAdapter.apply {
                    setSortType(type)
                    notifyDataSetChanged()
                }
            }
        }

    }catch (e : Exception){
        Timber.tag(TAG).d("initSortButton" + e.message)
    }

}