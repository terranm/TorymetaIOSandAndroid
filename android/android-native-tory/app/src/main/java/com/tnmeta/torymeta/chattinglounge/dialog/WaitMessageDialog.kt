package com.tnmeta.torymeta.chattinglounge.dialog

import android.app.AlertDialog
import android.app.Dialog
import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.Window
import androidx.constraintlayout.widget.ConstraintLayout
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.CommonAlertDialogBinding
import com.tnmeta.torymeta.databinding.WaitMessageDialogBinding
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.isVisible
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible


class WaitMessageDialog(context: Context) : Dialog(context) {

    var viewBinding : WaitMessageDialogBinding

    init {
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        viewBinding = WaitMessageDialogBinding.inflate(LayoutInflater.from(context))
        setContentView(viewBinding.root)
        setCancelable(false)
    }

    private fun setNegativeButton(title: String = context.getString(R.string.system_alert_btn_cancel), onClick: () -> Unit) {
        viewBinding.negativeBtn.text = title
        viewBinding.negativeBtn.setOnClickListener {
            onClick()
            dismiss()
        }
    }
    fun setNegativeButton(titleResId: Int, onClick: () -> Unit) = setNegativeButton(context.getString(titleResId), onClick)

}