package com.tnmeta.torymeta.intro

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.fragment.findNavController
import com.google.android.gms.tasks.Task
import com.google.firebase.messaging.FirebaseMessaging
import com.tnmeta.torymeta.BuildConfig
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.databinding.FragmentSplashBinding
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


class SplashFragment : BaseFragment(), EasyPermissions.PermissionCallbacks {

    companion object {
        val TAG : String = SplashFragment::class.java.simpleName

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
            Manifest.permission.POST_NOTIFICATIONS
        )

        private const val PERMISSION      = 1000
        private const val SPLASH_DURATION = 500L
        private const val REPLACE_MAIN_SCHEDULER_INTERVAL = 1000L

        fun newInstance() = SplashFragment().apply {}

        private var initUnit = false
    }

    private lateinit var viewBinding: FragmentSplashBinding

    private var isDataInitialized = false
    private var isSplashFinished = false

    private var replaceMainScheduler: Timer? = null


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = FragmentSplashBinding.inflate(inflater, container, false)
        viewBinding.apply {

        }
        return viewBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewBinding.apply {

            try {
                CoroutineScope(Dispatchers.Main).launch {
                    delay(SPLASH_DURATION)
                    isSplashFinished = true
                }

                if (Utilts.instance.netWorkCheck(requireContext())) {

                    FirebaseMessaging.getInstance().token.addOnCompleteListener { task: Task<String> ->
                        if (task.isSuccessful) {
                            Timber.tag(TAG).d("fcm ${task.result}")

                            if (Constants.is_FirebaseAnalytics) {
                                firebaseAnalyticsID(FirebaseParam.mobile_intro)
                            }

                            replaceMainScheduler = kotlin.concurrent.timer(period = REPLACE_MAIN_SCHEDULER_INTERVAL) {
                                if (isSplashFinished && isDataInitialized) {

                                    replaceMainScheduler?.cancel()
                                    replaceMainScheduler = null

                                    Timber.d("onViewCreated - timer")

                                    replaceMainScene()

                                }
                            }
                            checkVersion()
                        }
                    }
                }

            } catch (e: Exception) {
                Timber.tag(TAG).d("onViewCreated ${e.message}")
            }
        }

    }

    private fun checkVersion() = try {
        if(!Constants.IS_PRODUCTION_SERVER) {
            checkLogin()
        }else {
            repository.checkVersion(BuildConfig.VERSION_NAME).subscribeBy(onNext = {
                when (it.updateType) {
                    UpdateType.UPDATE_OPTIONAL -> {
                        CommonAlertDialog.Builder(requireContext())
                            .setCancelable(false)
                            .setMessage(R.string.system_alert_update)
                            .setNegativeButton(R.string.system_alert_update_btn_cancel) {
                                checkLogin()
                            }
                            .setPositiveButton(R.string.system_alert_update_btn_update) {
                                Utilts.instance.runMarket(requireActivity(), requireContext().packageName)
                                requireActivity().finish()
                            }
                            .show()
                    }

                    UpdateType.UPDATE -> {
                        CommonAlertDialog.Builder(requireContext())
                            .setCancelable(false)
                            .setMessage(R.string.system_alert_update)
                            .setPositiveButton(R.string.system_alert_update_btn_update) {
                                Utilts.instance.runMarket(requireActivity(), requireContext().packageName)
                                requireActivity().finish()
                            }
                            .show()
                    }

                    else -> {
                        checkLogin()
                    }
                }
            }, onError = {})
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

    private fun checkLogin() {
        if( !repository.isAutoLogin() ) {
            onBoardingLauncher.launch(Intent(requireActivity(), OnboardingActivity::class.java))

        } else {
            initData()
        }
    }

    private val onBoardingLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == AppCompatActivity.RESULT_OK) {
            if( repository.getLoginToken().isNullOrEmpty() ) {
                requireActivity().finish()
            } else {
                initData()
            }
        } else {
            requireActivity().finish()
        }
    }


    private fun initData() = try {
        Timber.d("SplashFragment - initData")
        repository.apply {
            //val params = BaseParam(InitVersion(BuildConfig.VERSION_NAME)).parameter
            val params = BaseParam(InitVersion(BuildConfig.VERSION_NAME, Build.MODEL, Build.VERSION.RELEASE)).parameter
            initData(params).subscribeBy(onNext = {
                //isDataInitialized = true
                toryApplication.apply {
                    initIAB(repository.toryItemList)
                }

                if(member.value!!.universityCode == null) {
                    member.value!!.universityCode = ""
                }

                getEventInfo().subscribeBy(onNext = {
                    eventArray.apply {
                        clear()
                        addAll(it.eventList)

                    }
                }, onError = {})

                val pushTokenParam = BaseParam(PushTokenParam(getFCMToken())).parameter
                setPushToken(pushTokenParam).subscribeBy(onNext = {
                    if(it.isSucceed) {
                        Timber.d("setPushToken " + it.processYn)
                        isDataInitialized = true
                    }
                }, onError = {})

            }, onError = {
                try {
                    val error = it.initCause(it.cause) as HttpException
                    if (error.code() == HTTP_FORBIDDEN) {
                        onBoardingLauncher.launch(
                            Intent(requireContext(), OnboardingActivity::class.java)
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
    private fun replaceMainScene() {
        try {

            /*
            val deniedCount = perMissionRequest.count {
                ContextCompat.checkSelfPermission(requireContext(), it) == PackageManager.PERMISSION_DENIED
            }

            if(deniedCount == perMissionRequest.size && !repository.getPermissionInfo()) {
                permissionActivityResult.launch(Intent(requireContext(), PermissionInfoActivity::class.java))
            }else {
                goMainScene()
            }
             */

            if(!repository.getPermissionInfo()) {
                permissionActivityResult.launch(Intent(requireContext(), PermissionInfoActivity::class.java))
            }else {
                goMainScene()
            }

        }catch (e : Exception){

            Timber.d(e.message)
        }
    }

    /**
     * 학교 선택화면으로 전환합니다
     */
    private val univSelectLauncher: ActivityResultLauncher<Intent> = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
        if( it.resultCode == AppCompatActivity.RESULT_OK) {
            replaceMainScene()
        }
    }

    private fun replaceUnivSelectScene() {
        if(repository.member.value!!.certUniYn == 1) {
            univSelectLauncher.launch(Intent(requireContext(), UniversitySelectActivity::class.java))
        }else {
            univSelectLauncher.launch(
                Intent(requireContext(), UniversitySelectActivity::class.java)
            )
        }
    }


    private val permissionActivityResult = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if(result.resultCode == AppCompatActivity.RESULT_OK) {
            repository.setPermissionInfo(true)
            permissionRequest()
        }else {
            goMainScene()
        }
    }

    @AfterPermissionGranted(PERMISSION)
    private fun permissionRequest() = try {
        if (EasyPermissions.hasPermissions(requireContext(), *perMissionRequest)) {
            goMainScene()
        }
        else {

            EasyPermissions.requestPermissions(this, resources.getString(R.string.str_permission_message), PERMISSION, *perMissionRequest)

        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    override fun onRequestPermissionsResult(CODE: Int, PERMISSIONS: Array<String?>, GRANTED: IntArray) {
        super.onRequestPermissionsResult(CODE, PERMISSIONS, GRANTED)
        EasyPermissions.onRequestPermissionsResult(CODE, PERMISSIONS, GRANTED, this)
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

    private fun goMainScene() = try {
//        CoroutineScope(Dispatchers.Main).launch {
//            initSetAvatar()
//            delay(1000)
//            //requireMember()
//        }

        if (repository.member.value!!.certUniYn == 0) {
            CoroutineScope(Dispatchers.Main).launch {
                findNavController().navigate(R.id.action_splash_to_mainfragment)
            }
        } else {
            repository.getMyCampusBuildingMarker()
                .subscribeBy(onComplete = {
                    CoroutineScope(Dispatchers.Main).launch {
                        findNavController().navigate(R.id.action_splash_to_mainfragment)
                    }

                }, onError = {})
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


    fun onSendToNative(currentActivity: Activity) = try {
        Timber.d("onSendToNative")
        CoroutineScope(Dispatchers.Main).launch {
            initUnit = true
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

}