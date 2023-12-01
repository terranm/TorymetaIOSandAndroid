package com.tnmeta.torymeta.talk

import android.content.Intent
import android.util.Log
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.ApiMode
import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.intro.UniversitySelectActivity
import com.tnmeta.torymeta.model.dto.FriendDTO
import com.tnmeta.torymeta.talk.ui.FriendCellData
import com.tnmeta.torymeta.talk.ui.FriendDetailView
import com.tnmeta.torymeta.talk.ui.FriendListAdapter
import com.tnmeta.torymeta.ui.CommonAlertDialog
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber

class FriendListHelper(val activity: BaseActivity) {
    companion object {
        val TAG : String = FriendListHelper::class.java.simpleName
    }

    private val repository: ToryRepository = activity.repository
    val datas = ArrayList<FriendCellData>()
    val adapter: FriendListAdapter = FriendListAdapter(datas)

    var onClickCellListener: ((FriendCellData) -> Unit)? = null

    init {
        initAdapter()
    }

    /**
     * 어댑터 초기화
     */
    private fun initAdapter() {
        adapter.onClickCellListener = onClick@{ data ->
            val listener = this.onClickCellListener ?: return@onClick
            listener(data)
        }

        // 친구 요청
        adapter.onClickRequest = {
            //Log.i(TAG, "onClickRequest: ${it.profileName}")
            Timber.tag(TAG).d("onClickRequest: ${it.profileName}")

            repository.sendRequestFriend(ApiMode.UIMode.NONE, it.memberId)
                .subscribeBy(onNext = { result ->
                    if( result.isSucceed ) {
                        Toast.makeText(activity, activity.getString(R.string.friend_alert_send_request, it.profileName), Toast.LENGTH_SHORT).show()
                    }
                }, onError = {})
        }

        // 친구 요청 수락
        adapter.onClickAccept = { friendData ->
            Log.i(TAG, "onClickAccept: ${friendData.profileName}")

            repository.acceptFriend(ApiMode.UIMode.NONE, friendData.memberId)
                .subscribeBy(onNext = { result ->
                    if( result.isSucceed ) {
                        Toast.makeText(activity, activity.getString(R.string.friend_alert_accept, friendData.profileName), Toast.LENGTH_SHORT).show()

                        repository.getFriendList(ApiMode.UIMode.NONE)
                        repository.getFriendRequestList(ApiMode.UIMode.NONE)
                    }
                }, onError = {})
        }

        // 친구 차단
        adapter.onClickBlock = { friendData ->
            CommonAlertDialog.Builder(activity)
                .setCancelable(true)
                .setTitle(R.string.friend_alert_block_title)
                .setMessage(activity.getString(R.string.friend_alert_block_msg, friendData.profileName))
                .setNegativeButton(R.string.system_alert_btn_cancel) {
                }
                .setPositiveButton(R.string.friend_alert_block_btn) {
                    // api
                    repository.blockFriend(ApiMode.UIMode.NONE, friendData.memberId)
                        .subscribeBy(onNext = { result ->
                            if( result.isSucceed ) {
                                repository.getFriendList(ApiMode.UIMode.NONE)
                                repository.getFriendBlockList(ApiMode.UIMode.NONE)
                            }
                        }, onError = {})
                }
                .show()
        }

        // 친구 차단 해제
        adapter.onClickUnblock = { friendData ->

            CommonAlertDialog.Builder(activity)
                .setCancelable(true)
                .setTitle(R.string.friend_cell_unblock)
                .setMessage(activity.getString(R.string.unblock_friend_title_msg, friendData.profileName))
                .setNegativeButton(R.string.system_alert_btn_cancel) {
                }
                .setPositiveButton(R.string.friend_alert_unblock_btn) {
                    // api
                    repository.unblockFriend(ApiMode.UIMode.NONE, friendData.memberId)
                        .subscribeBy(onNext = { result ->
                            if( result.isSucceed ) {
                                repository.getFriendList(ApiMode.UIMode.NONE)
                                repository.getFriendBlockList(ApiMode.UIMode.NONE)
                            }
                        }, onError = {})
                }
                .show()
        }

        // 친구 삭제
        adapter.onClickDelete = { friendData ->
            CommonAlertDialog.Builder(activity)
                .setCancelable(true)
                .setTitle(R.string.friend_alert_delete_title)
                .setMessage(activity.getString(R.string.friend_alert_delete_msg, friendData.profileName))
                .setNegativeButton(R.string.system_alert_btn_cancel) {
                }
                .setPositiveButton(R.string.friend_alert_delete_btn) {
                    // api
                    repository.deleteFriend(ApiMode.UIMode.NONE, friendData.memberId)
                        .subscribeBy(onNext = { result ->
                            if( result.isSucceed ) {
                                repository.getFriendList(ApiMode.UIMode.NONE)
                                repository.getFriendMayKnowList(ApiMode.UIMode.NONE)
                            }
                        }, onError = {})
                }
                .show()
        }
    }

    /**
     * 데이터 업데이트
     */
    fun updateData(onUpdate: (ArrayList<FriendCellData>) -> Unit) {
        val t = System.currentTimeMillis()

        onUpdate(datas)
        adapter.notifyDataSetChanged()

        Log.i(TAG, "updateData delta time: ${System.currentTimeMillis()-t}")
    }

    /**
     * 친구 상세 화면을 노출합니다
     */
    fun showFriendDetailView(data: FriendDTO) {
        FriendDetailView(activity, data, repository).run {
            onClickListener = {
                Intent(activity, ChattingActivity::class.java).run {
                    activity.startActivity(this)
                }
            }
            show()
        }
    }

    /**
     * 검색 화면으로 전환합니다
     */
    fun replaceSearchScene(type: FriendListType) {
        searchLauncher.launch(FriendSearchActivity.createIntent(activity, type))
    }

    private val searchLauncher: ActivityResultLauncher<Intent> = activity.registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == AppCompatActivity.RESULT_OK ) {
        }
    }
}