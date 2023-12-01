package com.tnmeta.torymeta.intro

import android.Manifest
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import com.tnmeta.torymeta.BuildConfig
import com.tnmeta.torymeta.MainBaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivitySplashBinding
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.UpdateType
import com.tnmeta.torymeta.model.param.InitVersion
import com.tnmeta.torymeta.model.param.PushTokenParam
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.utils.Utilts
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import okhttp3.internal.http.HTTP_FORBIDDEN
import pub.devrel.easypermissions.AfterPermissionGranted
import pub.devrel.easypermissions.EasyPermissions
import retrofit2.HttpException
import timber.log.Timber
import java.util.*

/**
 * 스플래쉬 화면
 */
class SplashActivity: BaseActivity(), EasyPermissions.PermissionCallbacks {
    companion object {
        val TAG : String = SplashActivity::class.java.simpleName

        ///앱 권한 목록
        private val perMissionRequest = arrayOf (
            Manifest.permission.CAMERA,
            Manifest.permission.RECORD_AUDIO,
            Manifest.permission.READ_CONTACTS,
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.BODY_SENSORS,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.CALL_PHONE,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.READ_PHONE_NUMBERS,
            Manifest.permission.ACTIVITY_RECOGNITION,
            Manifest.permission.POST_NOTIFICATIONS,
            Manifest.permission.READ_MEDIA_IMAGES
        )

        private const val PERMISSION      = 1000
        private const val SPLASH_DURATION = 500L
        private const val REPLACE_MAIN_SCHEDULER_INTERVAL = 1000L
    }

    private var isDataInitialized = false
    private var isSplashFinished = false

    // 메인으로 전환할지 체크하는 스케줄러
    private var replaceMainScheduler: Timer? = null

    private val viewBinding by viewBinding(ActivitySplashBinding::inflate)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {
                setContentView(root)
                window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

                CoroutineScope(Dispatchers.Main).launch {
                    delay(SPLASH_DURATION)
                    isSplashFinished = true
                }

                if (Constants.is_FirebaseAnalytics) {
                    firebaseAnalyticsID(FirebaseParam.mobile_intro)
                }

                replaceMainScheduler = kotlin.concurrent.timer(period = REPLACE_MAIN_SCHEDULER_INTERVAL) {
                    if (isSplashFinished && isDataInitialized) {
                        replaceMainScheduler?.cancel()
                        replaceMainScheduler = null

                        replaceMainScene()
                    }
                }

                Timber.tag(TAG).d(" language ${Locale.getDefault().language}")
                checkVersion()

                /*
                if(intent.hasExtra(Params.PUSH_DATA_PARAM)) {
                    val pushInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        intent.getParcelableExtra(Params.PUSH_DATA_PARAM, PushMessageInfo::class.java)!!
                    } else {
                        intent.getParcelableExtra(Params.PUSH_DATA_PARAM)!!
                    }

                    Timber.tag(TAG).d("SplashActivity onCreate - $pushInfo")
                }
                 */
            }
        }catch (e : Exception){
            Timber.tag(TAG).d(e.message)
        }
    }

    override fun onDestroy() = try {
        if(replaceMainScheduler != null) {
            replaceMainScheduler?.cancel()
            replaceMainScheduler = null
        }
        super.onDestroy()
    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }



    /**
     * 앱 버전 체크
     */
    private fun checkVersion() = try {

        Timber.tag(TAG).d("checkVersion ${BuildConfig.VERSION_NAME}")

        repository.checkVersion(BuildConfig.VERSION_NAME).subscribeBy(onNext = {
            Timber.tag(TAG).d("checkVersion - ${BuildConfig.VERSION_NAME} - ${it.appStatus}")
            when (it.updateType) {
                UpdateType.UPDATE_OPTIONAL -> {
                    CommonAlertDialog.Builder(this)
                        .setCancelable(false)
                        .setMessage(R.string.system_alert_update)
                        .setNegativeButton(R.string.system_alert_update_btn_cancel){
                            checkLogin()
                        }
                        .setPositiveButton(R.string.system_alert_update_btn_update) {
                            Utilts.instance.runMarket(this, packageName)
                            finish()
                        }
                        .show()
                }

                UpdateType.UPDATE -> {
                    CommonAlertDialog.Builder(this)
                        .setCancelable(false)
                        .setMessage(R.string.system_alert_update)
                        .setPositiveButton(R.string.system_alert_update_btn_update) {
                            Utilts.instance.runMarket(this, packageName)
                            finish()
                        }
                        .show()
                }

                else -> checkLogin()
            }
        }, onError = {})

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }

    /**
     * 로그인 체크
     */
    private fun checkLogin() = try {
        if( !repository.isAutoLogin() ) {
            onBoardingLauncher.launch(Intent(applicationContext, OnboardingActivity::class.java))
        } else {
            initData()
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    private val onBoardingLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == RESULT_OK ) {
            if( repository.getLoginToken().isNullOrEmpty() ) {
                finish()
            } else {
                initData()
            }
        } else {
            finish()
        }
    }

    /**
     * 데이터를 초기화합니다
     */
    private fun initData() = try {
        repository.apply {
            val params = BaseParam(InitVersion(BuildConfig.VERSION_NAME, Build.MODEL, Build.VERSION.RELEASE, Constants.BannerType)).parameter
            Timber.tag(TAG).d("initData $params")
            initData(params).subscribeBy(onNext = {
                isDataInitialized = true
                toryApplication.apply {
                    initIAB(repository.toryItemList)
                }

                if(member.value!!.universityCode == null) {
                    member.value!!.universityCode = ""
                }

                ///push token 업데이트 처리
                val pushTokenParam = BaseParam(PushTokenParam(getFCMToken())).parameter
                setPushToken(pushTokenParam).subscribeBy(onNext = {
                        if(it.isSucceed) {
                            Timber.d("setPushToken " + it.processYn)
                        }
                    }, onError = {})

                ///이벤트 리스트 처리 
                getEventList().subscribeBy(onNext = {
                    eventArray.apply {
                            clear()
                            addAll(it.eventList)
                        }
                }, onError = {})

            }, onError = {
                try {
                    val error = it.initCause(it.cause) as HttpException
                    if (error.code() == HTTP_FORBIDDEN) {
                        onBoardingLauncher.launch(
                            Intent(applicationContext, OnboardingActivity::class.java)
                                .putExtra(OnboardingActivity.RE_LOGIN, true)
                        )
                    }
                }catch (e : Exception){
                    Timber.d(e.message)
                }
            })

        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    /**
     * 메인 화면으로 전환합니다
     */
    private fun replaceMainScene() = try {
        if(!repository.getPermissionInfo()) {
            permissionActivityResult.launch(Intent(this@SplashActivity, PermissionInfoActivity::class.java))
        }else {
            goMainScene()
        }
    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }

    /**
     * 학교 선택화면으로 전환합니다
     */
    private val univSelectLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == RESULT_OK ) {
            replaceMainScene()
        }
    }

    private fun replaceUnivSelectScene() {
        /*
        if(repository.member.value!!.certUniYn == 1) {
            univSelectLauncher.launch(Intent(applicationContext, UniversitySelectActivity::class.java))
        }else {
            univSelectLauncher.launch(
                Intent(applicationContext, UniversitySelectActivity::class.java)
            )
        }
         */
        univSelectLauncher.launch(
            Intent(applicationContext, UniversitySelectActivity::class.java)
        )
    }


    /**
     * permissionActivityResult
     */
    private val permissionActivityResult = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if(result.resultCode == RESULT_OK) {
            repository.setPermissionInfo(true)
            permissionRequest()
        }else {
            goMainScene()
        }
    }

    @AfterPermissionGranted(PERMISSION)
    private fun permissionRequest() = try {
        if (EasyPermissions.hasPermissions(this, *perMissionRequest)) {
            goMainScene()

        } else {

            EasyPermissions.requestPermissions(this, resources.getString(R.string.str_permission_message), PERMISSION, *perMissionRequest)

        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    override fun onRequestPermissionsResult(code: Int, permissions: Array<String?>, granted: IntArray) {
        super.onRequestPermissionsResult(code, permissions, granted)
        EasyPermissions.onRequestPermissionsResult(code, permissions, granted, this)
        try {
            goMainScene()

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onPermissionsGranted(requestCode: Int, perms: MutableList<String>) {
        Timber.d("")
    }

    override fun onPermissionsDenied(requestCode: Int, perms: MutableList<String>) {

    }

    /**
     * goMainScene()
     */
    private fun goMainScene() = try {

        repository.apply {
            if(member.value!!.certUniYn == 0 || member.value!!.universityCode.isNullOrEmpty()) {
                Intent(applicationContext, MainBaseActivity::class.java).run {
                    startActivity(this)
                    finish()
                }
            }else {
                getMyCampusBuildingMarker().subscribeBy(onComplete = {

//                    if(intent.hasExtra(Params.PUSH_DATA_PARAM)) {
//                        /*
//                        val pushInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//                            intent.getParcelableExtra(Params.PUSH_DATA_PARAM, PushMessageInfo::class.java)!!
//                        } else {
//                            intent.getParcelableExtra(Params.PUSH_DATA_PARAM)!!
//                        }
//                        */
//                        Intent(applicationContext, MainBaseActivity::class.java).run {
//                            putExtra(Params.PUSH_DATA_PARAM, pushInfo)
//                            startActivity(this)
//                            finish()
//                        }
//                    }else {
//                        Intent(applicationContext, MainBaseActivity::class.java).run {
//                            startActivity(this)
//                            finish()
//                        }
//                    }

                    Intent(applicationContext, MainBaseActivity::class.java).run {
                        startActivity(this)
                        finish()
                    }

                }, onError = {})
            }
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

}