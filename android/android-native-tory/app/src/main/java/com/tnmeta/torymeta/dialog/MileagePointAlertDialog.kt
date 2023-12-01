package com.tnmeta.torymeta.dialog

import android.app.AlertDialog
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.MileagePointAlertDialogBinding
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible

object MileagePointAlertDialog {

    private const val THEME_ID = R.style.AppTheme_Dialog

    class Builder(val context: Context) {

        private val viewBinding = MileagePointAlertDialogBinding.inflate(LayoutInflater.from(context))

        private var builder: AlertDialog.Builder = AlertDialog.Builder(context, THEME_ID).apply {

            viewBinding.apply {

                arrayOf(title, message, positiveBtn).forEach {
                    it.text = ""
                }

                setCancelable(false)
                setView(root)
            }
        }
        private var dialog: AlertDialog? = null

        init {
        }

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

        fun setImage(index : Int) : Builder {
            viewBinding.apply {
                val image = if (index == 1) R.drawable.step_inner_img else R.drawable.step_out_img
                icon.setBackgroundResource(image)
            }
            return this
        }

        fun setMessage(messageResId: Int): Builder = setMessage(context.getString(messageResId))

        fun setPositiveButton(title: String = context.getString(R.string.system_alert_btn_ok), onClick: () -> Unit): Builder {
            viewBinding.positiveBtn.text = title
            viewBinding.positiveBtn.setOnClickListener {
                onClick()
                dialog?.dismiss()
            }
            return this
        }
        fun setPositiveButton(titleResId: Int, onClick: () -> Unit): Builder = setPositiveButton(context.getString(titleResId), onClick)

        fun show() {
            // update title and message
            arrayOf(viewBinding.title, viewBinding.message).forEach {
                it.setVisible(it.text.isNotEmpty())
            }

            dialog = builder.show()
        }
    }
}