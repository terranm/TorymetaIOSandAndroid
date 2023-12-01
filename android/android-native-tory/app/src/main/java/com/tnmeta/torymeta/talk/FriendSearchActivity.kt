package com.tnmeta.torymeta.talk

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.inputmethod.InputMethodManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityFriendSearchBinding
import com.tnmeta.torymeta.model.ButtonData
import com.tnmeta.torymeta.model.dto.FriendDTO
import com.tnmeta.torymeta.talk.ui.FriendCellData
import com.tnmeta.torymeta.talk.ui.FriendListDivider
import com.tnmeta.torymeta.ui.CommonBottomButtonListSheet
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible



/**
 * 친구 검색 화면
 */
class FriendSearchActivity: BaseActivity() {
    companion object {
        val TAG : String = FriendSearchActivity::class.java.simpleName

        const val PARAM_TYPE = "type"

        fun createIntent(context: Context, type: FriendListType): Intent {
            return Intent(context, FriendSearchActivity::class.java).apply {
                putExtra(PARAM_TYPE, type.i)
            }
        }
    }

    var type: FriendListType = FriendListType.INVALID
    lateinit var friendListHelper: FriendListHelper

    private val viewBinding by viewBinding(ActivityFriendSearchBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {

            setContentView(root)
            setTopBarTitle(viewBinding.topBar, getString(R.string.friend_search_title))
            setTopBarBackButtonEnabled(viewBinding.topBar, true) {
                finish()
            }


            initEditBox()
            initList()

            updateType(FriendListType.toType(intent.getIntExtra(PARAM_TYPE, FriendListType.INVALID.i)))

            // 드랍다운 버튼 클릭
            dropdownBtn.setOnClickListener {
                hideKeyboard()
                showDropdownSheet()
            }
        }
    }

    /**
     * 타입 변경
     */
    private fun updateType(type: FriendListType) = viewBinding.apply {
        this@FriendSearchActivity.type = type
        dropdownTitle.text = FriendConstants.getTitle(this@FriendSearchActivity, type)
        updateFriendList(editBox.text.toString())
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
    private fun updateFriendList(inputStr: String) {
        val isNumber = (inputStr.toIntOrNull() != null)

        friendListHelper.updateData { datas ->
            datas.clear()

            if( inputStr.isNullOrEmpty() ) {
                return@updateData
            }

            val cellType = FriendListCellType.toType(type)
            val list = repository.getCacheFriendDataList(type)

            list.forEach { data ->
                if( isNumber ) {
                    if( data.phoneNum != null && data.phoneNum.contains(inputStr) && inputStr.length > 3 ) {
                        datas.add(FriendCellData(cellType, data))
                    }
                } else {
                    val profileName = data.profileName.lowercase()
                    if( profileName.contains(inputStr.lowercase()) ) {
                        datas.add(FriendCellData(cellType, data))
                    }
                }
            }
        }
    }

    /**
     * 검색창 초기화
     */
    private fun initEditBox() = viewBinding.apply {
        editBox.addTextChangedListener(object: TextWatcher {
            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                val inputStr = p0 ?: return
                Log.i("d1", "textChanged: $inputStr")
                updateFriendList(inputStr.toString())

                // update delete button visible
                editBoxDeleteBtn.setVisible(inputStr.isNotEmpty())
            }

            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

            override fun afterTextChanged(p0: Editable?) {

            }
        })

//        editBox.setOnEditorActionListener { textView, keyCode, keyEvent ->
//            false
//        }

        // 텍스트 삭제 버튼 클릭
        editBoxDeleteBtn.setOnClickListener {
            editBox.setText("")
        }

        // 화면 터치 시 키보드 숨김
        friendSearchLayout.setOnTouchListener { view, motionEvent ->
            hideKeyboard()
            false
        }
    }

    private fun hideKeyboard() {
        if( currentFocus != null ) {
            val inputManager = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
            inputManager.hideSoftInputFromWindow(currentFocus!!.windowToken, InputMethodManager.HIDE_NOT_ALWAYS)
        }
    }

    /**
     * 목록 초기화
     */
    private fun initList() = viewBinding.apply {
        friendListHelper = FriendListHelper(this@FriendSearchActivity)
        friendListHelper.onClickCellListener = {
            onClickCell(it)
        }

        listView.layoutManager = LinearLayoutManager(this@FriendSearchActivity, RecyclerView.VERTICAL, false)
        listView.addItemDecoration(FriendListDivider())
        listView.adapter = friendListHelper.adapter

        // 리스트 터치 시 키보드 숨김
        listView.setOnTouchListener { view, motionEvent ->
            hideKeyboard()
            false
        }
    }

    /**
     * 드랍다운 하단 시트 노출
     */
    private fun showDropdownSheet() {
        val buttons = listOf(
            ButtonData(
                FriendListType.NEW,
                R.drawable.common_corner_medium_white, R.string.friend_list_title_new, R.color.tory_black
            ),
            ButtonData(
                FriendListType.REQUEST,
                R.drawable.common_corner_medium_white, R.string.friend_list_title_request, R.color.tory_black
            ),
            ButtonData(
                FriendListType.CAMPUS,
                R.drawable.common_corner_medium_white, R.string.friend_list_title_campus, R.color.tory_black
            ),
            ButtonData(
                FriendListType.UNKNOWN_LOCATION, R.drawable.common_corner_medium_white, R.string.friend_list_title_unknown_location, R.color.tory_black
            ),
            ButtonData(
                FriendListType.BLOCK, R.drawable.common_corner_medium_white, R.string.friend_list_title_block, R.color.tory_black
            ),
            ButtonData(
                FriendListType.INVALID, R.drawable.common_corner_medium_purple, R.string.profile_change_sheet_btn_cancel, R.color.tory_white
            ),
        )

        val sheet = CommonBottomButtonListSheet(this, buttons)
        sheet.onClickListener = onClickListener@ {
            val type = it as FriendListType
            if( type == FriendListType.INVALID ) {
                return@onClickListener
            }

            updateType(type)
        }
        sheet.show()
    }
}