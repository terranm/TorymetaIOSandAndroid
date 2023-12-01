package com.tnmeta.torymeta.unity.unitycall

import com.google.gson.GsonBuilder
import com.tnmeta.torymeta.common.ToryMetaCallFunction
import com.tnmeta.torymeta.common.ToryMetaCallObject
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.avatar.info.UnitMessageInfo
import com.unity3d.player.UnityPlayer
import timber.log.Timber

class NativeSendUnity : Any() {

    companion object {
        val TAG : String = NativeSendUnity::class.java.simpleName

        @JvmStatic
        val instance by lazy { NativeSendUnity() }
    }

    /**
     * onNativeSendToUnity
     * @param type
     * @param valueParam
     */
    fun onNativeSendToUnity(typeParam: String, valueParam : Any?) = try {

        val messageInfo = UnitMessageInfo(
                                type = typeParam,
                                value = valueParam )

        //val params = GsonBuilder().setPrettyPrinting().serializeNulls().create().toJson(messageInfo)

        val params = BaseParam(messageInfo).parameter.toString()

        Timber.tag(TAG).d("onNativeSendToUnity $params")

        UnityPlayer.UnitySendMessage(
                    ToryMetaCallObject.NativeManager.trim(),
                    ToryMetaCallFunction.SendToUnity.trim(),
                    params )

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


}