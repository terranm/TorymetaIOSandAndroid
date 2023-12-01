package com.tnmeta.torymeta.campus.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.tnmeta.torymeta.campus.worker.StepsCounterWorker
import timber.log.Timber

class AppUpdatedReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        try {
            if (intent.action != Intent.ACTION_MY_PACKAGE_REPLACED) return

            Timber.d("App updated")

            StepsCounterWorker.enqueuePeriodicWork(context)
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }
}
