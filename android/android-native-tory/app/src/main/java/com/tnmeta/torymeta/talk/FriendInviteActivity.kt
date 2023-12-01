package com.tnmeta.torymeta.talk


import android.os.Bundle
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityFriendInviteBinding
import com.tnmeta.torymeta.model.TransitionModeType


class FriendInviteActivity : BaseActivity(TransitionModeType.SLIDE_IN_RIGTH) {

    private val viewBinding by viewBinding(ActivityFriendInviteBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
            setTopBarTitle(viewBinding.topBar, R.string.friend_invite)
            setTopBarBackButtonEnabled(viewBinding.topBar,true) {
                finish()
            }

            comfirm.setOnClickListener {
                onFriendInvite()
            }
        }
    }

    private fun onFriendInvite() = viewBinding.apply {

    }


}