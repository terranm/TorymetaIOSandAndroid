package com.tnmeta.torymeta.unity.unitycall

import android.app.Activity
import com.google.gson.Gson
import com.google.gson.JsonParser
import com.tnmeta.torymeta.common.ToryMetaCallFunction
import com.tnmeta.torymeta.common.ToryMetaCallObject
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.avatar.info.UnitMessageInfo
import com.tnmeta.torymeta.model.unity.ActionId
import com.tnmeta.torymeta.model.unity.NativeShowModal
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.unity3d.player.UnityPlayer
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber

class UnityNativeShowModal : Any() {

    /*
    companion object {
        @Volatile
        private var INSTANCE: UnityNativeShowModal? = null

        @Synchronized
        fun getInstance(currentActivity : Activity): UnityNativeShowModal = INSTANCE ?: UnityNativeShowModal(param).also { INSTANCE = it }
    }
    */

    companion object {
        val TAG : String = UnityNativeShowModal::class.java.simpleName

        @JvmStatic
        val instance by lazy { UnityNativeShowModal() }
    }


    /**
     * onNativeShowModal
     */
    fun onNativeShowModal(currentActivity : Activity, jsonString: String) {
        try {
            val jsonElement = JsonParser.parseString(jsonString).asJsonObject.get("value")
            if(jsonElement.isJsonNull)
                return

            Timber.tag(TAG).d("onNativeShowModal %s", jsonElement)

            val nativeShowModal = Gson().fromJson(jsonElement.asJsonObject, NativeShowModal::class.java)

            when(nativeShowModal.buttons.size) {
                1 -> onSigleButtonDialog(currentActivity, nativeShowModal)
                2 -> onMultiButtonDialog(currentActivity, nativeShowModal)
            }

        }catch (e : Exception){
            Timber.tag(TAG).d("onNativeShowModal ${e.message}")
        }
    }

    /**
     * onSigleButtonDialog
     *
     * @param currentActivity
     * @param showInfo
     */
    private fun onSigleButtonDialog(currentActivity: Activity, showInfo : NativeShowModal) {
        showInfo.apply {
            CommonAlertDialog.Builder(currentActivity)
                .setMessage(description)
                .setPositive(buttons[0].title, buttons[0].color) {
                    Timber.tag(TAG).d("onNativeShowModal ${buttons[0].actionId}")

                    val values = ActionId(
                        actionId = buttons[0].actionId
                    )

                    NativeSendUnity.instance.onNativeSendToUnity(
                        typeParam = ToryMetaMessageType.DoAction,
                        valueParam = values
                    )
                }
                .show()
        }
    }



    /**
     * onMultiButtonDialog
     * @param currentActivity
     * @param showInfo
     */
    private fun onMultiButtonDialog(currentActivity: Activity, showInfo : NativeShowModal) = try {
        showInfo.apply {


            val dialog = CommonAlertDialog.Builder(currentActivity)
                .setMessage(description)
                .setNegative(buttons[0].title,  buttons[0].color) {
                    if(buttons[0].actionId.isNotEmpty()) {
                        val values = ActionId(
                            actionId = buttons[0].actionId
                        )

                        NativeSendUnity.instance.onNativeSendToUnity(
                            typeParam = ToryMetaMessageType.DoAction,
                            valueParam = values
                        )
                    }
                }
                .setPositive(buttons[1].title, buttons[1].color) {

                    if(buttons[1].actionId.isNotEmpty()) {
                        val values = ActionId(
                            actionId = buttons[1].actionId
                        )

                        NativeSendUnity.instance.onNativeSendToUnity(
                            typeParam = ToryMetaMessageType.DoAction,
                            valueParam = values
                        )
                    }
                }
                .show()
        }

    }catch (e: Exception){
        Timber.tag(TAG).d(e.message)
    }



    /**
     * onDoAction
     */
//    private fun onDoAction(actionId: ActionId) = try {
//        val messageInfo = UnitMessageInfo(
//            type = ToryMetaMessageType.DoAction,
//            value = actionId
//        )
//
//        val params = BaseParam(messageInfo).parameter.toString()
//
//        UnityPlayer.UnitySendMessage(
//            ToryMetaCallObject.NativeManager.trim(),
//            ToryMetaCallFunction.SendToUnity.trim(),
//            params
//        )
//    }catch (e : Exception){
//        Timber.d(e.message)
//    }


}