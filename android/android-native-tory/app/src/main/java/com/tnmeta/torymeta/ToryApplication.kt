package com.tnmeta.torymeta

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.multidex.MultiDexApplication
import androidx.startup.AppInitializer
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging
import com.pixplicity.easyprefs.library.Prefs
import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.iab.BillingDataSource
import com.tnmeta.torymeta.intro.SplashActivity
import com.tnmeta.torymeta.model.dto.ToryItemDTO
import com.tnmeta.torymeta.utils.SBSharedPreferences
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import net.danlew.android.joda.JodaTimeInitializer
import timber.log.Timber
import kotlin.system.exitProcess

class ToryApplication: MultiDexApplication() {
    companion object {
        //var mPushMessage : PushMessageInfo? = null

        var isToryWordEnter = false
        var isToryWordBack = false
        var isUnityLoad = false

        var context: Context? = null
        var activity: Activity? = null
        val localStorage: SBSharedPreferences by lazy { SBSharedPreferences(context!!) }

        fun getInstance(context: Activity): ToryApplication {
            return context.application as ToryApplication
        }

        fun getRepository(context: Activity): ToryRepository {
            return getInstance(context).repository
        }

        /**
         * 앱을 종료합니다
         */
        public fun exitApp() {
            activity?.finishAffinity()
            exitProcess(0)
        }

        /**
         * 네트워크 에러 알림 팝업
         */
        fun showNetworkErrorPopup() {
            CoroutineScope(Dispatchers.Main).launch {
                AlertDialog.Builder(activity!!)
                    .setCancelable(false)
                    .setMessage(R.string.system_alert_network_error_restart)
                    .setPositiveButton(R.string.system_alert_btn_ok) { p0, p1 ->
                        exitApp()
                    }
                    .show()
            }
        }
    }

    val applicationScope = GlobalScope
    lateinit var repository: ToryRepository
    lateinit var iabHelper: BillingDataSource

    var isShowingDialog = false
    var isinitUnity = false


    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        context = base
    }

    override fun onCreate() {
        super.onCreate()
        repository = ToryRepository()

        FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
            if( task.isSuccessful ) {
                Timber.d("fcm - " + task.result.toString())
                repository.setFCMToken(task.result)
            }
        })

        if (BuildConfig.DEBUG) {
            Timber.plant(Timber.DebugTree())
        }

        Prefs.Builder()
            .setContext(this)
            .setMode(ContextWrapper.MODE_PRIVATE)
            .setPrefsName("prefs")
            .setUseDefaultSharedPreference(false)
            .build()

        AppInitializer.getInstance(this).initializeComponent(JodaTimeInitializer::class.java)
    }

    /**
     * 인앱 결제 라이브러리 초기화
     */
    fun initIAB(toryItemList: List<ToryItemDTO>) {
        val itemIdList = run {
            val items = ArrayList<String>()

            toryItemList.forEach {
                if( it.isEnabled ) {
                    items.add(it.itemId.lowercase()/*소문자 변환*/)
                }
            }

            items.toTypedArray()
        }

        iabHelper = BillingDataSource.getInstance(this@ToryApplication, applicationScope,
            itemIdList, null, itemIdList
        )
    }

    /**
     * 스플래쉬 화면으로 전환합니다. 이전 Activity는 모두 종료됩니다.
     */
    fun replaceSplashScene() {
        activity?.let {
            Toast.makeText(it, "앱이 재시작되어 스플래쉬 화면으로 이동합니다", Toast.LENGTH_SHORT).show()

            val intent = Intent(it, SplashActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            }
            startActivity(intent)

            it.finishAffinity()
        }
    }

    /**
     * 앱이 백그라운드로 전환됩니다
     */
    fun onAppBackground() {
        // SocketIO.enterBackground()
    }

    /**
     * 앱이 포어그라운드로 전환됩니다
     */
    fun onAppForeground() {
        // SocketIO.enterForeground()
    }
}

