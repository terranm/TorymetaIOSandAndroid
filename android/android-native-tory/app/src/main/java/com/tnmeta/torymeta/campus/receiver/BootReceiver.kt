package com.tnmeta.torymeta.campus.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.tnmeta.torymeta.campus.worker.StepsCounterWorker
import com.tnmeta.torymeta.database.step.PedometerDatabase
import com.tnmeta.torymeta.database.step.StepsRepository
import timber.log.Timber

class BootReceiver : BroadcastReceiver(){

    private lateinit var stepsRepository: StepsRepository

    override fun onReceive(context: Context, intent: Intent) {
        try {
            if (intent.action != Intent.ACTION_BOOT_COMPLETED) return
            if (!::stepsRepository.isInitialized) {
                stepsRepository = StepsRepository(PedometerDatabase.getInstance(context))
                stepsRepository.updateStepsSinceBoot(0)
            }

            StepsCounterWorker.enqueuePeriodicWork(context)

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }
}