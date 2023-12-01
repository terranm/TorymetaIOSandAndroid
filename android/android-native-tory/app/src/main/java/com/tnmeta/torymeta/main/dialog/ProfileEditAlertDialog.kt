package com.tnmeta.torymeta.main.dialog

import android.app.AlertDialog
import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.InputType
import android.view.LayoutInflater
import android.view.View
import android.view.inputmethod.EditorInfo
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.MileagePointAlertDialogBinding
import com.tnmeta.torymeta.databinding.ProfileEditAlertDialogBinding
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible

object ProfileEditAlertDialog {

    private const val THEME_ID = R.style.AppTheme_Dialog

    class Builder(val context: Context, var onClick: (String) -> Unit) {

        private val viewBinding = ProfileEditAlertDialogBinding.inflate(LayoutInflater.from(context))

        private var builder: AlertDialog.Builder = AlertDialog.Builder(context, THEME_ID).apply {

            viewBinding.apply {

                setCancelable(false)
                setView(root)

                close.setOnClickListener {
                    dialog?.dismiss()
                }

                positiveBtn.setOnClickListener {
                    onClickListener?.let { it -> it(editProfile.text.toString()) }
                    dialog?.dismiss()
                }

                editProfile.run {
                    imeOptions = EditorInfo.IME_ACTION_DONE
                    setRawInputType(InputType.TYPE_CLASS_TEXT)
                }

                editProfile.setOnEditorActionListener { _, actionId, _ ->
                    if (actionId == EditorInfo.IME_ACTION_DONE) {
                        onClick(editProfile.text.toString())
                        dialog?.dismiss()
                        true
                    } else {
                        false
                    }
                }
            }
        }
        private var dialog: AlertDialog? = null

        fun setCancelable(cancelable: Boolean): Builder {
            builder.setCancelable(cancelable)
            return this
        }

        fun setTitle(title: String): Builder {
            viewBinding.title.text = title
            return this
        }

        fun setTitleView(isView : Boolean) : Builder {
            viewBinding.title.visibility = if (isView) View.VISIBLE else View.INVISIBLE
            return this
        }

        fun setTitle(titleResId: Int): Builder = setTitle(context.getString(titleResId))

        fun setMessage(message: String): Builder {
            viewBinding.message.text = message
            return this
        }

        fun setMessage(messageResId: Int): Builder = setMessage(context.getString(messageResId))

        fun setNickName(nickName : String) : Builder {
            viewBinding.editProfile.setText(nickName)
            return this
        }

        fun setPositiveButton(title: String = context.getString(R.string.system_alert_btn_ok), onClickListener: ((String)) -> Unit): Builder {
            viewBinding.apply {
                positiveBtn.apply {
                    setOnClickListener {
                        onClickListener?.let { it -> it(editProfile.text.toString()) }
                        dialog?.dismiss()
                    }
                }
            }
            return this
        }

        fun setPositiveButton(titleResId: Int, onClick: () -> Unit): Builder = setPositiveButton(context.getString(titleResId), onClickListener!! )

        var onClickListener: ((String) -> Unit)? = null

        fun show() {
            dialog = builder.show()
        }
    }
}