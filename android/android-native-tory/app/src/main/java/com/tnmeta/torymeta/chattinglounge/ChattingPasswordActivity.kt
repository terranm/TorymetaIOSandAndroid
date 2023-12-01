package com.tnmeta.torymeta.chattinglounge

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.ToryMetaCallFunction
import com.tnmeta.torymeta.common.ToryMetaCallObject
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityChattingLougeListBinding
import com.tnmeta.torymeta.databinding.ActivityChattingPasswordBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.avatar.info.UnitMessageInfo
import com.tnmeta.torymeta.model.enumtype.ChattingMode
import com.tnmeta.torymeta.unity.unitycall.UnityFormCall
import com.unity3d.player.UnityPlayer
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber

class ChattingPasswordActivity : BaseActivity(), View.OnClickListener {
    companion object {
        val  TAG : String = ChattingPasswordActivity::class.java.simpleName

        const val ChattingPassWord = "ChattingPassWord"
    }

    private val viewBinding by viewBinding(ActivityChattingPasswordBinding::inflate)
    private var chattingPassword = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
            if(intent.hasExtra(ChattingPassWord)) {
                chattingPassword = intent.getStringExtra(ChattingPassWord)!!
            }

            enterLayout.apply {
                isEnabled = false
                setBackgroundResource(R.drawable.common_corner_round_gray_02)
            }

            editPassword.run {
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                    override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {
                        txtMessage.text = ""
                        enterLayout.isEnabled = if(editPassword.text.toString().isNotEmpty() && editPassword.text.toString().length > 1) {
                            enterLayout.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                            true
                        }else {
                            enterLayout.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                            false
                        }
                    }
                    override fun afterTextChanged(editable: Editable?) {}
                })
            }

            arrayOf(enterLayout).forEach {
                it.setOnClickListener(this@ChattingPasswordActivity)
            }
        }
    }

    override fun onResume() {
        super.onResume()
        setFullScreen()
    }


    override fun onClick(view: View) {
        when(view.id) {
            R.id.close -> finish()
            R.id.enter_layout -> {
                viewBinding.apply {
                    try {
                        if (chattingPassword != editPassword.text.toString()) {
                            txtMessage.text = resources.getString(R.string.chatting_room_password_comfirm_message)
                            return@apply
                        }

                        CoroutineScope(Dispatchers.Main).launch {
                            onDoAction(ToryMetaMessageType.ChatJoin)
                        }

                    } catch (e: Exception) {
                        Timber.d(e.message)
                    }
                }
            }
        }
    }

    private fun onDoAction(type: String) = try {
        Timber.tag(UnityFormCall.TAG).d("onDoAction $type")

        val messageInfo = UnitMessageInfo(
            type = type,
            value = null
        )

        val params = BaseParam(messageInfo).parameter.toString()

        UnityPlayer.UnitySendMessage(
            ToryMetaCallObject.NativeManager.trim(),
            ToryMetaCallFunction.SendToUnity.trim(),
            params
        )

    }catch (e : Exception){
        Timber.tag(UnityFormCall.TAG).d(e.message)
    }


}