package com.tnmeta.torymeta.chattinglounge

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.core.content.ContextCompat
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.chattinglounge.model.ChattingLounge
import com.tnmeta.torymeta.common.ToryMetaCallFunction
import com.tnmeta.torymeta.common.ToryMetaCallObject
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityChattingLougeCreateBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.avatar.info.UnitMessageInfo
import com.tnmeta.torymeta.model.enumtype.ChattingMode
import com.unity3d.player.UnityPlayer
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class ChattingLoungeCreateActivity : BaseActivity(), View.OnClickListener {
    companion object {
        val TAG: String = ChattingLoungeCreateActivity::class.java.simpleName

        fun createIntent(context: Context): Intent {
            return Intent(context, ChattingLoungeCreateActivity::class.java)
        }
    }

    private var chattingMode = ChattingMode.PUBLICMODE

    private val viewBinding by viewBinding(ActivityChattingLougeCreateBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
            chattingCreate.apply {
                isEnabled = false
                setOnClickListener(this@ChattingLoungeCreateActivity)
            }

            editTitle.run{
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                    override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {
                        isEnableCheck()

                    }
                    override fun afterTextChanged(editable: Editable?) {}
                })
            }

            editPasswordComfirm.run {
                addTextChangedListener(object : TextWatcher {
                    override fun beforeTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {}
                    override fun onTextChanged(charSequence: CharSequence, p1: Int, p2: Int, p3: Int) {
                        /*
                        if(editPassword.text.toString().isNotEmpty() && editPasswordComfirm.text.toString().length > 2) {
                            isEnableCheck()
                        }
                         */
                        isEnableCheck()
                    }
                    override fun afterTextChanged(editable: Editable?) {}
                })
            }

            arrayOf(chattingOpen, chattingClose).forEach {
                it.setOnClickListener(this@ChattingLoungeCreateActivity)
            }
        }
    }

    override fun onResume() {
        super.onResume()
        setFullScreen()
    }


    override fun onBackPressed() {
        //super.onBackPressed()
    }

    override fun onClick(view : View) {
        when(view.id) {
            R.id.close -> finish()
            R.id.chatting_create -> {
                try {
                    viewBinding.apply {
                        if (editTitle.text.toString().isEmpty()) {
                            CoroutineScope(Dispatchers.Main).launch {
                                editTitle.requestFocus()
                            }
                            return@apply
                        }

                        val chattingValue = ChattingLounge(
                            roomName   = editTitle.text.toString(),
                            isPrivate  = chattingMode == ChattingMode.PRIVATEMODE,
                            password   = editPassword.text.toString()
                        )

                        /*
                        val params = BaseParam(
                            UnitMessageInfo(type = ToryMetaMessageType.ChatCreate, value = chattingValue)).parameter


                        UnityPlayer.UnitySendMessage(
                            ToryMetaCallObject.NativeManager,
                            ToryMetaCallFunction.SendToUnity,
                            params.toString()
                        )
                        */

                        sendNativeUnityMessage(type = ToryMetaMessageType.ChatCreate,
                                                valueParam = chattingValue)

                        finish()
                    }
                }catch (e : Exception){
                    Timber.tag(TAG).e("ChattingLounge ${e.message}")
                }
            }

            R.id.chatting_open -> {
                chattingMode = ChattingMode.PUBLICMODE
                viewBinding.apply {
                    passwordLayout.visibility = View.GONE
                }
            }

            R.id.chatting_close -> {
                chattingMode = ChattingMode.PRIVATEMODE
                viewBinding.apply {
                    passwordLayout.visibility = View.VISIBLE
                }
            }
        }
    }

    private fun isEnableCheck() = viewBinding.apply {
        if(chattingMode == ChattingMode.PUBLICMODE) {
            chattingCreate.isEnabled = editTitle.text.toString().isNotEmpty()
        }else {
            if(editTitle.text.toString().isNotEmpty()) {
                chattingCreate.isEnabled = if(editPassword.text.toString().isNotEmpty() && editPassword.text.toString() == editPasswordComfirm.text.toString()) {
                    txtMessage.apply {
                        text = resources.getString(R.string.chatting_room_password_message)
                        setTextColor(ContextCompat.getColor(this@ChattingLoungeCreateActivity, R.color.tory_purple))
                    }
                    true
                }else {
                    if(editPassword.text.toString().isEmpty() && editPasswordComfirm.text.toString().isEmpty()) {
                        txtMessage.text = ""
                    }else {
                        txtMessage.apply {
                            text = resources.getString(R.string.chatting_room_password_error_message)
                            setTextColor(ContextCompat.getColor(this@ChattingLoungeCreateActivity, R.color.color_red_ff))
                        }
                    }
                    false
                }
            }else {
                chattingCreate.isEnabled = false
            }
        }
    }


}