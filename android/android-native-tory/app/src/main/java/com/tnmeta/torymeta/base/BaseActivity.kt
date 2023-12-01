package com.tnmeta.torymeta.base

import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.gson.GsonBuilder
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.ToryMetaCallFunction
import com.tnmeta.torymeta.common.ToryMetaCallObject
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.databinding.CommonTopBarBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.model.TransitionModeType
import com.tnmeta.torymeta.model.unity.SwitchScene
import com.tnmeta.torymeta.model.unity.avatar.info.AvatarState
import com.tnmeta.torymeta.model.unity.avatar.info.AvatarValue
import com.tnmeta.torymeta.model.unity.avatar.info.UnitMessageInfo
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible
import com.unity3d.player.UnityPlayer
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


/**
 * Activity Super Class
 */
open class BaseActivity(private val transitionMode: TransitionModeType = TransitionModeType.NONE): AppCompatActivity() {

    val toryApplication: ToryApplication by lazy { application as ToryApplication }
    val repository: ToryRepository by lazy { toryApplication.repository }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ToryApplication.activity = this@BaseActivity

        when (transitionMode) {
            TransitionModeType.VERTICAL -> overridePendingTransition(R.anim.fade_in, R.anim.fade_out)
            TransitionModeType.SLIDE_IN_RIGTH -> overridePendingTransition(R.anim.slide_in_right, R.anim.slide_out_left)
            TransitionModeType.SLIDE_IN_LEFT-> overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right)
            TransitionModeType.SLIDE_UP_IN -> overridePendingTransition(R.anim.slide_up_in, R.anim.none)
            TransitionModeType.FADE_IN -> overridePendingTransition(R.anim.fade_in, R.anim.none)
            TransitionModeType.TOP_IN -> overridePendingTransition(R.anim.top_out, R.anim.none)
            TransitionModeType.SLIDE_IN_TOP -> overridePendingTransition(R.anim.abc_slide_out_top, R.anim.abc_slide_in_top)
            TransitionModeType.OPEN_NEXT -> overridePendingTransition(R.anim.open_next, R.anim.none)
            else -> Unit
        }
    }

    override fun finish() {
        super.finish()

        when (transitionMode) {
            TransitionModeType.VERTICAL -> overridePendingTransition(R.anim.fade_out, R.anim.none)
            TransitionModeType.SLIDE_IN_RIGTH -> overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right)
            TransitionModeType.SLIDE_UP_IN -> overridePendingTransition(R.anim.slide_up_out, R.anim.none)
            TransitionModeType.FADE_IN -> overridePendingTransition(R.anim.fade_out, R.anim.none)
            TransitionModeType.TOP_IN -> overridePendingTransition(R.anim.none, R.anim.none)
            TransitionModeType.OPEN_NEXT -> overridePendingTransition(R.anim.close_next, R.anim.none)
            else -> Unit
        }
    }



    override fun onResume() {
        ToryApplication.activity = this
        super.onResume()
    }

    override fun onPause() {
        toryApplication.onAppBackground()
        super.onPause()
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)

        if( hasFocus ) {
            toryApplication.onAppForeground()
        }
    }

    override fun onBackPressed() {
        super.onBackPressed()
    }

    /**
     * 상단바 타이틀 설정
     */
    protected fun setTopBarTitle(topBarBinding: CommonTopBarBinding, title: String) {
        topBarBinding.title.text = title
    }


    protected fun setTopBarTitle(topBarBinding : CommonTopBarBinding, resId: Int) = setTopBarTitle(topBarBinding, getString(resId))
    /**
     * 상단바 뒤로가기 버튼 활성화
     */
    protected fun setTopBarBackButtonEnabled(topBarBinding : CommonTopBarBinding, isEnabled: Boolean, onClickListener: (() -> Unit)? = null) {
        topBarBinding.backBtn.setVisible(isEnabled)
        if( isEnabled ) {
            topBarBinding.backBtn.setOnClickListener {
                onClickListener?.let {
                    it()
                }
            }
        }
    }

    protected fun firebaseAnalyticsID(eventID : String) = try {

        FirebaseAnalytics.getInstance(this).apply {
            logEvent(eventID, Bundle().apply {
                putString(FirebaseParam.type, FirebaseParam.type_value)
            })
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

    protected fun firebaseAnalyticsMember(eventID : String) = try {
        FirebaseAnalytics.getInstance(this).apply {
            logEvent(eventID,  Bundle().apply {
                putString(FirebaseParam.type, FirebaseParam.type_value)
                putString(FirebaseParam.member_id, repository.member.value!!.memberId.toString())
            })
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

    protected fun setTitleColor(isEnabled: Boolean) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
            window.statusBarColor = if(isEnabled) ContextCompat.getColor(baseContext, R.color.white)
                                    else ContextCompat.getColor(baseContext, R.color.tory_purple)
            WindowInsetsControllerCompat(window, window.decorView).isAppearanceLightStatusBars = true
        }
    }


    /**
     * setFullScreen
     */
    protected fun setFullScreen() {
        supportActionBar?.hide()

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.setDecorFitsSystemWindows(false)
            window.insetsController?.apply {
                hide(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
                systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            }
        }else {
            @Suppress("DEPRECATION")
            window.decorView.systemUiVisibility = (
                            View.SYSTEM_UI_FLAG_IMMERSIVE
                            or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                            or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                            or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                            or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                            or View.SYSTEM_UI_FLAG_FULLSCREEN)

            @Suppress("DEPRECATION")
            window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
        }
    }

    protected fun setNormalScreen() {
        supportActionBar?.show()
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.setDecorFitsSystemWindows(true)
            window.insetsController?.apply {
                show(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
                systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            }
        }else {
            @Suppress("DEPRECATION")
            window.decorView.systemUiVisibility = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                    or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                    or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
        }

    }

    protected fun initSetAvatar() = try {
        repository.apply {
            val avatarValue = AvatarValue (
                userName = member.value!!.profileName,
                memberId = member.value!!.memberId,
                avatarState = AvatarState(
                    skinCode        =  myAvatarAttr.value!!.skinCode,
                    skinColorCode   =  myAvatarAttr.value!!.skinColorCode,

                    faceCode        =  myAvatarAttr.value!!.faceCode,
                    faceColorCode   =  myAvatarAttr.value!!.faceColorCode,

                    hairCode        =  myAvatarAttr.value!!.hairCode,
                    hairColorCode   =  myAvatarAttr.value!!.hairColorCode,

                    topCode         =  myAvatarAttr.value!!.topCode,
                    topColorCode    =  myAvatarAttr.value!!.topColorCode,

                    bottomCode      =  myAvatarAttr.value!!.bottomCode,
                    bottomColorCode =  myAvatarAttr.value!!.bottomColorCode,

                    shoesCode        =  myAvatarAttr.value!!.shoesCode,
                    shoesColorCode   =  myAvatarAttr.value!!.shoesColorCode,

                    bodyType        =  myAvatarAttr.value!!.bodyCode
                )
            )

            sendNativeUnityMessage(type = ToryMetaMessageType.AvatarInfo,
                valueParam = avatarValue)
        }

    }catch (e : Exception){
        Timber.d("initSetAvatar " + e.message)
    }


    /**
     * sendNativeUnityMessage
     * @param type
     * @param valueParam
     */
    protected fun sendNativeUnityMessage(type : String, valueParam : Any?) = try {
        CoroutineScope(Dispatchers.Main).launch {
            val messageInfo = UnitMessageInfo(
                type = type,
                value = valueParam
            )

            Timber.tag(MainFragment.TAG).d("sendNativeUnityMessage - %s", messageInfo.toString())

            val params = GsonBuilder().setPrettyPrinting().serializeNulls().create().toJson(messageInfo)

            Timber.tag(MainFragment.TAG).d("sendNativeUnityMessage type - %s", type)
            Timber.tag(MainFragment.TAG).d("sendNativeUnityMessage - %s", params)

            UnityPlayer.UnitySendMessage(
                ToryMetaCallObject.NativeManager.trim(),
                ToryMetaCallFunction.SendToUnity.trim(),
                params
            )
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    protected fun enterChattingRoom(tableId : String) = SwitchScene (
        url = "",
        roomType = "",
        roomId = "",
        roomTitle = "",
        videoStartTime = "",
        isAppRelease = Constants.IS_PRODUCTION_SERVER,
        scene = ToryMetaSceneParam.lobby,
        tableId = tableId
    )

}