package com.tnmeta.torymeta.messaging

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.GsonBuilder
import com.tnmeta.torymeta.MainBaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.intro.SplashActivity
import com.tnmeta.torymeta.model.push.PushMessageInfo
import com.tnmeta.torymeta.push.PushInfoActivity
import timber.log.Timber

class SBFirebaseMessagingService: FirebaseMessagingService() {
    companion object {
        private const val TAG = "SBFirebaseMsgService"
    }


    /**
     * Called when message is received.
     *
     * @param remoteMessage Object representing the message received from Firebase Cloud Messaging.
     */
    // [START receive_message]
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        Timber.tag(TAG).d("From: " + remoteMessage.from)

        if(remoteMessage != null  && remoteMessage.data.isNotEmpty()) {
            sendNotification(remoteMessage)
        }
    }


    private fun sendNotification(remoteMessage : RemoteMessage) {
        val msg = mHandler.obtainMessage()
        msg.apply {
            obj = remoteMessage
        }
        mHandler.sendMessage(msg)
    }


    private var mHandler : Handler = object : Handler(Looper.getMainLooper()) {
        override fun handleMessage(msg: Message) {
            notificationPush(msg.obj as RemoteMessage)
        }
    }


    private fun notificationPush(messageBody: RemoteMessage) = try {

        Timber.tag(TAG).d("notificationPush  ")

        val title = messageBody.notification!!.title
        val body = messageBody.notification!!.body

        Timber.tag(TAG).d("notificationPush  " +  messageBody.data.toString())
        val data = messageBody.data.toString()

        val notifyTitle = messageBody.data["title"].toString()
        val notifyContent = messageBody.data["content"].toString()
        val notifyActionUrl = messageBody.data["action_url"].toString()

        val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val intent = Intent(applicationContext, PushInfoActivity::class.java)
        val pushInfo = PushMessageInfo(notifyTitle, notifyContent, notifyActionUrl)
        intent.run {
            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_NEW_TASK )
            putExtra(Params.PUSH_DATA_PARAM, pushInfo)
        }

        val pendingIntent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            PendingIntent.getActivity(
                applicationContext,
                0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
            )
        } else {
            PendingIntent.getActivity(
                applicationContext,
                0, intent, PendingIntent.FLAG_UPDATE_CURRENT
            )
        }

        val builder = NotificationCompat.Builder(applicationContext, getString(R.string.app_name))
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(title)
            .setContentText(notifyContent)
            .setDefaults(Notification.DEFAULT_VIBRATE)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            val channel = NotificationChannel(getString(R.string.app_name) , getString(R.string.app_name) , NotificationManager.IMPORTANCE_HIGH)
            channel.apply {
                description = getString(R.string.app_name)
                enableLights(true)
                lightColor = Color.BLUE
                enableVibration(true)
                vibrationPattern = longArrayOf(100, 200, 100, 200)
                lockscreenVisibility = NotificationCompat.VISIBILITY_PUBLIC
            }

            notificationManager.createNotificationChannel(channel)

        }else {
            builder.setSmallIcon(R.mipmap.ic_launcher);
        }

        notificationManager.notify(1, builder.build())

    }catch (e : Exception ) {
        Timber.d(e.message)
    }


    /**
     * Called if the FCM registration token is updated. This may occur if the security of
     * the previous token had been compromised. Note that this is called when the
     * FCM registration token is initially generated so this is where you would retrieve the token.
     */
    override fun onNewToken(token: String) {
    }
    // [END on_new_token]



}
