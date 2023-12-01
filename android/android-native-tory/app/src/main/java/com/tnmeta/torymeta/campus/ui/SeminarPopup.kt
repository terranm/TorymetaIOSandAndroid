package com.tnmeta.torymeta.campus.ui


import android.app.AlertDialog
import android.content.Context
import android.view.LayoutInflater
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.SeminarPopupBinding


/**
 * 세미나 안내 팝업
 */
object SeminarPopup {
    private const val THEME_ID = R.style.AppTheme_Dialog

    class Builder(val context: Context) {

        private val viewBinding = SeminarPopupBinding.inflate(LayoutInflater.from(context))
        private var builder: AlertDialog.Builder = AlertDialog.Builder(context, THEME_ID).apply {
            setCancelable(false)
            setView(viewBinding.root)
        }
        private var dialog: AlertDialog? = null

        init {
        }

        fun setCancelable(cancelable: Boolean): Builder {
            builder.setCancelable(cancelable)
            return this
        }

        fun onEnterButton(onClick: () -> Unit): Builder {
            viewBinding.enterBtn.setOnClickListener {
                onClick()
                dialog?.dismiss()
            }
            return this
        }

        fun onClose(onClick: () -> Unit) : Builder {
            viewBinding.closeBtn.setOnClickListener {
                onClick()
                dialog?.dismiss()
            }
            return this
        }

        fun show() {
            dialog = builder.show()

        }
    }
}
