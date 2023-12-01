package com.tnmeta.torymeta.seminar.main

import android.content.Context
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.Utilts

class SeminarMessage {

    fun showAlertMessage(context: Context, messageId: Int) {
        CommonAlertDialog.Builder(context)
            .setCancelable(false)
            .setMessage(messageResId =  messageId)
            .setPositiveButton(R.string.system_alert_btn_ok) {}
            .show()
    }

    fun showAlertMessage(context: Context, message: String) {
        CommonAlertDialog.Builder(context)
            .setCancelable(false)
            .setMessage(message = message)
            .setPositiveButton(R.string.system_alert_btn_ok) {}
            .show()
    }


    companion object {
        @JvmStatic
        val instance by lazy { SeminarMessage() }
    }

}