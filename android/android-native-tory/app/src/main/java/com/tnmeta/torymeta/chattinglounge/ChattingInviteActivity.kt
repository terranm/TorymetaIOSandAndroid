package com.tnmeta.torymeta.chattinglounge

import android.Manifest
import android.content.ContentResolver

import android.database.Cursor
import android.net.Uri
import android.os.Bundle
import android.provider.ContactsContract
import android.view.View
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.chattinglounge.adapter.InviteViewAdapter
import com.tnmeta.torymeta.chattinglounge.viewmodel.ChattingInviteViewModel
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ActivityChattingInviteBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.MemberInfo
import com.tnmeta.torymeta.model.PhoneInfo
import com.tnmeta.torymeta.model.PhoneList
import com.tnmeta.torymeta.model.unity.invite.ChatInvite
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.ui.CommonLoadingView
import com.tnmeta.torymeta.utils.PermissionHelper
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


/**
 * class ChattingInviteActivity
 */
class ChattingInviteActivity : BaseActivity(), View.OnClickListener {
    companion object {
        val  TAG : String = ChattingInviteActivity::class.java.simpleName
        const val  InviteParam     = "InviteParam"

        private val PERMISSIONS = arrayOf(
            Manifest.permission.READ_CONTACTS
        )
    }

    private val viewBinding by viewBinding(ActivityChattingInviteBinding::inflate)
    private lateinit var viewModel: ChattingInviteViewModel

    private lateinit var mInviteAdapter : InviteViewAdapter
    private val mInviteArray = ArrayList<MemberInfo>()
    private var tableID : String? = null

    private val phoneList = ArrayList<PhoneInfo>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {
                setContentView(root)
                if(intent.hasExtra(InviteParam)) {
                    tableID = intent.getStringExtra(InviteParam)!!
                }

                viewModel = ViewModelProvider(this@ChattingInviteActivity)[ChattingInviteViewModel::class.java]
                mInviteAdapter = InviteViewAdapter(
                    items = mInviteArray,
                    onItemClick = { memberInfo ->
                        onChatInvite(memberInfo)
                    },
                    onItemViewClick = { memberInfo ->
                        onChatInvite(memberInfo)
                    }
                )

                inviteRecyclerView.apply {
                    layoutManager = LinearLayoutManager(this@ChattingInviteActivity)
                    setDivider(R.drawable.menu_view_divider)
                    adapter = mInviteAdapter
                }


                fetchContacts()

                viewModel.apply {
                    friendList.observe(this@ChattingInviteActivity) {list ->
                        mInviteArray.apply {
                            clear()
                            addAll(list)
                        }

                        mInviteAdapter.notifyDataSetChanged()
                    }
                }
            }

        }catch (e : Exception){
            Timber.d("ChattingInviteActivity = ${e.message}")
        }
    }



    /**
     * onResume
     */
    override fun onResume() {
        super.onResume()
        setFullScreen()

    }


    /**
     * onClick
     * @param view
     */
    override fun onClick(view: View) {
        when(view.id){
            R.id.close -> finish()
        }
    }


    private fun fetchContacts() {
        try {
            if (!isPermissionGranted()) {
                requestPermission()
                return
            }

            CoroutineScope(Dispatchers.Main).launch {

                val loadingView = CommonLoadingView.createInRootView(this@ChattingInviteActivity)
                loadingView.show(false, 500)

                val resolver: ContentResolver = contentResolver
                val phoneUri: Uri = ContactsContract.CommonDataKinds.Phone.CONTENT_URI
                val cursor: Cursor? = resolver.query(phoneUri, null, null, null, ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME + " ASC")

                if (cursor != null) {
                    while (cursor.moveToNext()) {

                        //val id = cursor.getString(cursor.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.CONTACT_ID))
                        //val type = cursor.getInt(cursor.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.TYPE))

                        val name = cursor.getString(cursor.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME))
                        val number = cursor.getString(cursor.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.NUMBER))

                        val imageUri = cursor.getString(cursor.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.PHOTO_URI))
                        if (imageUri != null) {
                        }
                        var phoneNumber = number
                        phoneNumber = phoneNumber.replace("+82", "0")
                        phoneNumber = phoneNumber.replace("+82-", "0")
                        phoneNumber = phoneNumber.replace("-", "")

                        if (number != null) {
                            phoneList.add(
                                PhoneInfo(
                                    profileName = name,
                                    phoneNum = phoneNumber
                                )
                            )
                        }
                    }
                }

                cursor!!.close()

                val params = BaseParam(PhoneList(phoneList = phoneList)).parameter
                Timber.d("fetchContacts $params")
                loadingView.dismiss()

                viewModel.apply {
                    getFriendsInfo(params)
                }
            }


        }catch (e : Exception){
            Timber.d(e.message)
        }
    }


    private fun requestPermission() {
        // 이미 허용
        if( isPermissionGranted() ) {
            return
        }

        // 거부됨
        if( PermissionHelper.shouldShowRequestPermissionRationale(this, PERMISSIONS) ) {
            CommonAlertDialog.Builder(this)
                .setCancelable(false)
                .setMessage(R.string.system_alert_permission_denied)
                .setPositiveButton {
                }
                .show()
        }
        // 권한 요청
        else {
            permissionLauncher.launch(PERMISSIONS)
        }
    }

    private val permissionLauncher: ActivityResultLauncher<Array<String>> =
        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
            // 권한 허용됨
            if( PermissionHelper.isPermissionGranted(this, PERMISSIONS) ) {
                fetchContacts()
            }
            // 권한 거부함
            else {

            }
        }

    private fun isPermissionGranted(): Boolean {
        return PermissionHelper.isPermissionGranted(this, PERMISSIONS)
    }


    /**
     * onChatInvite
     *
     * @param info
     */
    private fun onChatInvite(info: MemberInfo) = try {
        val params = BaseParam(ChatInvite(
            friendId = info.memberId,
            tableId = tableID!!
        )).parameter

        viewModel.apply {
            pushChatInvite(params).subscribeBy(onNext = {
                if(it.result!!.inviteYn == "Y") {
                    Toast.makeText(this@ChattingInviteActivity, "초대하기를 전송하였습니다.", Toast.LENGTH_SHORT).show()
                    finish()
                }else {
                    CommonAlertDialog.Builder(this@ChattingInviteActivity)
                        .setMessage(it.resultMessage.toString())
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }
            }, onError = {})
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


}