package com.tnmeta.torymeta.chattinglounge.dialog

import android.app.AlertDialog
import android.content.Context
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.ChattingPasswordDialogBinding
import timber.log.Timber

object ChattingPasswordDialog {
    private const val THEME_ID = R.style.AppTheme_Dialog

    class Builder(val context: Context, private val chattingPassword : String) {

        private val viewBinding = ChattingPasswordDialogBinding.inflate(LayoutInflater.from(context))

        lateinit var onClickListener: ((Any) -> Unit)

        private var builder: AlertDialog.Builder = AlertDialog.Builder(context, THEME_ID).apply {
            try {
                viewBinding.apply {
                    setCancelable(false)
                    setView(root)

                    close.setOnClickListener {
                        dialog?.dismiss()
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
                                enterLayout.isEnabled = if(editPassword.text.toString().isNotEmpty() && editPassword.text.toString().isNotEmpty()) {
                                    enterLayout.setBackgroundResource(R.drawable.common_corner_round_purple_02)
                                    txtMessage.visibility = View.VISIBLE
                                    true
                                }else {
                                    enterLayout.setBackgroundResource(R.drawable.common_corner_round_gray_02)
                                    txtMessage.visibility = View.GONE
                                    false
                                }
                            }
                            override fun afterTextChanged(editable: Editable?) {}
                        })
                    }

                }
            }catch (e : Exception){
                Timber.d("ChattingPasswordDialog $e.message")
            }
        }

        fun setCancelable(cancelable: Boolean): Builder {
            builder.setCancelable(cancelable)
            return this
        }

        fun setOnEnterClick(onClick: () -> Unit) {
            viewBinding.apply {
                enterLayout.setOnClickListener {
                    if (chattingPassword != editPassword.text.toString()) {
                        txtMessage.text = context.getString(R.string.chatting_room_password_comfirm_message)
                        return@setOnClickListener
                    }

                    onClick()
                    dialog?.dismiss()
                }
            }
        }

        private var dialog: AlertDialog? = null

        fun show() {
            dialog = builder.show()
        }
    }

}