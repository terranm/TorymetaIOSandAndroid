package com.tnmeta.torymeta

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.navigation.NavController
import androidx.navigation.NavDestination
import androidx.navigation.findNavController
import androidx.navigation.fragment.NavHostFragment
import com.google.gson.JsonParser
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.ChattingAction
import com.tnmeta.torymeta.common.Params
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.common.ToryMetaUnityCallType
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.databinding.ActivityMainBaseBinding
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.main.MainFragmentDirections
import com.tnmeta.torymeta.model.push.PushMessageInfo
import com.tnmeta.torymeta.model.unity.avatar.info.SwitchSceneSimple
import com.tnmeta.torymeta.model.unity.JoinByPush
import com.tnmeta.torymeta.talk.ToryTalkActivity
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.unity.UnityUtils
import com.tnmeta.torymeta.unity.unitycall.UnityFormCall
import com.tnmeta.torymeta.unity.unitycall.UnityNativeBack
import com.tnmeta.torymeta.unity.unitycall.UnityNativeCallEtc
import com.tnmeta.torymeta.unity.unitycall.UnityNativeShowModal
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class MainBaseActivity : BaseActivity() {

    companion object {
        val TAG : String = MainBaseActivity::class.java.simpleName

        @JvmStatic
        fun sendToNative(currentActivity: Activity, message : String) {
            CoroutineScope(Dispatchers.Main).launch {
                newInstance().onSendToNative(currentActivity = currentActivity,
                                            message = message)
            }
        }

        @JvmStatic
        fun newInstance() =
            MainBaseActivity().apply {}
    }

    private val viewBinding by viewBinding(ActivityMainBaseBinding::inflate)
    private lateinit var navController: NavController
    private var backKeyPressedTime: Long = 0


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding.apply {
            setContentView(root)
            setupNavigation()
        }

    }

    private fun setupNavigation() = try {
        val navHostFragment = supportFragmentManager.findFragmentById(R.id.nav_host_fragment) as NavHostFragment
        navController = navHostFragment.navController

        val navGraph = navController.navInflater.inflate(R.navigation.nav_main)
        navGraph.setStartDestination(R.id.mainFragment)
        //navGraph.setStartDestination(R.id.splash)
        navController.graph = navGraph

    } catch (e: Exception) {
        Timber.d(e.message)
    }



    override fun onBackPressed() {
        try {

            val navDestination: NavDestination = navController.currentDestination ?: return

            when(navDestination.id) {
                R.id.mainFragment -> {
                    if (toryApplication.isShowingDialog) {
                        //super.getOnBackPressedDispatcher().onBackPressed()
                        super.onBackPressedDispatcher.onBackPressed()
                        return
                    }

                    if (System.currentTimeMillis() > backKeyPressedTime + 1500) {
                        backKeyPressedTime = System.currentTimeMillis()
                        Toast.makeText(this, R.string.system_alert_exit_app, Toast.LENGTH_SHORT).show()
                        return
                    }

                    if (System.currentTimeMillis() <= backKeyPressedTime + 1500) {
                        if (UnityUtils.getPlayer() != null)
                            UnityUtils.getPlayer().destroy()

                        //toryApplication.isEventBottomDialog = false
                        finish()
                    }

                    toryApplication.isinitUnity = false
                    return
                }

                R.id.toryavatar_profile -> {
                    CoroutineScope(Dispatchers.Main).launch {
                        val values =  SwitchSceneSimple(scene = ToryMetaSceneParam.AvatarView)
                        sendNativeUnityMessage(type = ToryMetaMessageType.SwitchSceneSimple,
                                                valueParam = values)
                    }
                }

                R.id.torymeta_world -> {
                    if(!ToryApplication.isToryWordBack) {
                        ToryApplication.isToryWordBack = false
                        return
                    }
                }
            }

            //super.onBackPressed()
            //super.getOnBackPressedDispatcher().onBackPressed()
            super.onBackPressedDispatcher.onBackPressed()
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }





    /**
     * onSendToNative
     */
    private fun onSendToNative(currentActivity: Activity, message : String) {
        try {
            val jsonElement = JsonParser.parseString(message).asJsonObject.get("type")
            if(jsonElement.isJsonNull)
                return

            Timber.d("onSendToNative $message")

            when (jsonElement.asString) {
                ToryMetaUnityCallType.Awake -> {

                    when(currentActivity.findNavController(R.id.nav_host_fragment).currentDestination?.id) {
                        R.id.splash -> {
                            MainFragment.newInstance().onMainAwake(currentActivity = currentActivity)
                        }
                    }
                }

                ToryMetaUnityCallType.OnDestroy -> {}

                ToryMetaUnityCallType.Start -> {

                    when (currentActivity.findNavController(R.id.nav_host_fragment).currentDestination?.id) {
                        R.id.mainFragment -> MainFragment.newInstance().onSendToNative(currentActivity, false)
                        //R.id.splash -> SplashFragment.newInstance().onSendToNative(currentActivity = currentActivity)
                    }
                }

                ToryMetaUnityCallType.NativeBack -> {
                    ToryApplication.isToryWordBack = true
                    ToryApplication.isToryWordEnter = false
                    UnityNativeBack.instance.onNativeBack(currentActivity = currentActivity)
                }

                ToryMetaUnityCallType.FormCall -> UnityFormCall.instance.onFormCall(currentActivity = currentActivity, jsonString = message)

                ToryMetaUnityCallType.NativeShowModal -> UnityNativeShowModal.instance.onNativeShowModal(currentActivity = currentActivity, jsonString = message)

                ToryMetaUnityCallType.RequireLoungeVideoUrl -> UnityNativeCallEtc.instance.requireLoungeVideoUrl(currentActivity = currentActivity)

                ToryMetaUnityCallType.RequireMember -> UnityNativeCallEtc.instance.requireMember(currentActivity = currentActivity)

                else -> {}
            }

        } catch (e: Exception) {
            Timber.d("onSendToNative -- ${e.message}")
        }
    }


    /**
     * onNewIntent
     * @param intent
     */
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)

        Timber.tag(TAG).d("MainBaseActivity - onNewIntent ")

        try {
            val pushInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                intent.getParcelableExtra(Params.PUSH_DATA_PARAM, PushMessageInfo::class.java)!!
            } else {
                intent.getParcelableExtra(Params.PUSH_DATA_PARAM)!!
            }

            val params = pushInfo!!.actionUrl!!.split(':')
            Timber.tag(TAG).d("onNewIntent - $params ")

            if(params[0] == "chatlounge") {
                CommonAlertDialog.Builder(this)
                    .setCancelable(false)
                    .setMessage(pushInfo.content)
                    .setNegativeButton(R.string.chatting_join_reject) {}
                    .setPositiveButton(R.string.chatting_join_accept) {
                        val infoData = enterChattingRoom(params[1])
                        Timber.tag(MainFragment.TAG).d("tory_lounge $infoData")

                        if(!ToryApplication.isToryWordEnter) {
                            val action = MainFragmentDirections.actionMainToTorymetaWorld(infoData)
                            navController.navigate(action)
                        }else {
                            val params = JoinByPush(tableId = params[1])
                            sendNativeUnityMessage(type = ChattingAction.JoinByPush,
                                valueParam = params)
                        }
                    }
                    .show()

            }else if(params[0] == "friend") {
                if(!ToryApplication.isToryWordEnter) {
                    Intent(this, ToryTalkActivity::class.java).run {
                        startActivity(this)
                    }
                }else {
                    CommonAlertDialog.Builder(this)
                        .setCancelable(false)
                        .setMessage(pushInfo.content)
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                        }
                        .show()
                }
            }

        } catch (e: Exception) {
            Timber.d("onNewIntent ${e.message}")
        }


    }


}