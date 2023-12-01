package com.tnmeta.torymeta.campus.worker

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.work.*
import com.tnmeta.torymeta.database.step.StepsRepository
import java.util.concurrent.TimeUnit
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.database.step.PedometerDatabase
import timber.log.Timber


class StepsCounterWorker constructor(
    appContext: Context,
    workerParams: WorkerParameters
) : CoroutineWorker(appContext, workerParams) {

    val stepsRepository = StepsRepository(PedometerDatabase.getInstance(appContext))

    override suspend fun doWork(): Result {
        //setForeground(getForegroundInfo())


        val sensorManager = applicationContext
            .getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val stepCounterSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)

        return if (stepCounterSensor != null) {
            val success = getStepsCount(sensorManager, stepCounterSensor)
            if (success) Result.success() else Result.retry()
        } else {
            Result.failure()
        }
    }

    private suspend fun getStepsCount(
        sensorManager: SensorManager,
        stepCounterSensor: Sensor
    ) = suspendCoroutine<Boolean> { continuation ->
        val listener = object : SensorEventListener {

            override fun onSensorChanged(event: SensorEvent?) {
                // Make sure to remove listener to avoid wasting resources
                sensorManager.unregisterListener(this)

                event?.values?.firstOrNull()?.let { steps ->
                    //val stepsToday = stepsRepository.updateStepsSinceBoot(steps.toLong())
                    //Timber.d("Step count: $steps, steps today: $stepsToday" )
                    continuation.resume(true)
                    return
                }
                continuation.resume(false)
            }

            override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
                Timber.d( sensor?.name + " accuracy changed: " + accuracy )
            }
        }

        sensorManager.registerListener(
            listener,
            stepCounterSensor,
            SensorManager.SENSOR_DELAY_NORMAL
        )
    }

    override suspend fun getForegroundInfo(): ForegroundInfo {
        val title = applicationContext.getString(R.string.notification_title)
        val content = applicationContext.getString(R.string.notification_content)

        // Create a Notification channel if necessary
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createNotificationChannel()
        }

        val notification = NotificationCompat.Builder(applicationContext, NOTIFICATION_CHANNEL_ID)
            .setContentTitle(title)
            .setTicker(content)
            .setContentText(content)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .build()

        return ForegroundInfo(NOTIFICATION_ID_UPDATING_STEPS, notification)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createNotificationChannel() {
        val channelName = applicationContext.getString(R.string.notification_channel_name)
        val description = applicationContext.getString(R.string.notification_channel_description)
        val importance = NotificationManager.IMPORTANCE_DEFAULT

        val mChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID, channelName, importance)
        mChannel.description = description

        val notificationManager = applicationContext
            .getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.createNotificationChannel(mChannel)
    }

    companion object {
        private const val NOTIFICATION_CHANNEL_ID = "Notification"
        private const val NOTIFICATION_ID_UPDATING_STEPS = 1

        fun enqueuePeriodicWork(context: Context) {
            val stepsCounterWorker =
                PeriodicWorkRequestBuilder<StepsCounterWorker>(15, TimeUnit.MINUTES)
                    .addTag("stepsWork")
                    .build()

            WorkManager.getInstance(context).enqueueUniquePeriodicWork(
                "periodicStepCounterWorker",
                ExistingPeriodicWorkPolicy.REPLACE,
                stepsCounterWorker
            )
        }
    }
}
