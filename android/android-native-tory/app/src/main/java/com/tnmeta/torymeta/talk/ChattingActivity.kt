package com.tnmeta.torymeta.talk

import android.content.Intent
import android.os.Bundle
import android.view.View
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityChattingBinding
import com.tnmeta.torymeta.model.ButtonData
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.ui.CommonBottomButtonListSheet
import timber.log.Timber

class ChattingActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH) {

    private val viewBinding by viewBinding(ActivityChattingBinding::inflate)

    enum class ChattingMoreType(val i: Int) {
        INVALID(0),
        ROOM_ACCUSE(1),
        ROOM_EXIT(2)                 // 차단
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)

            setTopBarTitle(viewBinding.topBar, R.string.tory_talk_title)
            setTopBarBackButtonEnabled(viewBinding.topBar,true) {
                finish()
            }

            chattingPeople.setOnClickListener {
                onChattingPeople()
            }
            moreBtn.setOnClickListener {
                showMoreMenuSheet()
            }
        }
    }


    private fun onChattingPeople() {
        ChattingPeopleView(this, onClickListener = {

            when(it as Int)  {
                R.id.inviteBtn -> {
                    Intent(this, FriendInviteActivity::class.java).run {
                        startActivity(this)
                    }
                }
            }

        }).run {
            show()
        }
    }


    private fun showMoreMenuSheet() = try {
        val buttons = listOf(
            ButtonData(
                ChattingMoreType.ROOM_ACCUSE,
                R.drawable.common_corner_medium_white, R.string.chatting_room_accuse, R.color.tory_purple
            ),

            ButtonData(
                ChattingMoreType.ROOM_EXIT,
                R.drawable.common_corner_medium_white, R.string.chatting_room_exit, R.color.color_red_ff
            ),

            ButtonData(
                ChattingMoreType.INVALID, R.drawable.common_corner_medium_purple, R.string.profile_change_sheet_btn_cancel, R.color.tory_white
            ),
        )

        val sheet = CommonBottomButtonListSheet(this, buttons)
        sheet.onClickListener = onClickListener@ {

            when(it as ChattingMoreType) {
                ChattingMoreType.ROOM_ACCUSE-> {
                }

                ChattingMoreType.ROOM_EXIT -> {

                }
                else-> {
                }
            }

        }
        sheet.show()

    }catch (e : Exception){
        Timber.d(e.message)
    }



}