package com.tnmeta.torymeta.base

import android.app.Activity
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.google.firebase.analytics.FirebaseAnalytics
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.ToryRepository
import com.tnmeta.torymeta.campus.ToryAvatarProfileFragment
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.common.ToryMetaCallFunction
import com.tnmeta.torymeta.common.ToryMetaCallObject
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.control.BundleFragment
import com.tnmeta.torymeta.main.MainFragment
import com.tnmeta.torymeta.main.MainFragmentDirections
import com.tnmeta.torymeta.main.model.RoomInfoDto
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.avatar.info.AvatarState
import com.tnmeta.torymeta.model.unity.avatar.info.AvatarValue
import com.tnmeta.torymeta.model.unity.avatar.info.CharacterSet
import com.tnmeta.torymeta.model.unity.avatar.info.UnitMessageInfo
import com.tnmeta.torymeta.model.meta.Member
import com.tnmeta.torymeta.model.meta.MetaVerseDto
import com.tnmeta.torymeta.model.meta.Options
import com.tnmeta.torymeta.model.unity.PassMember
import com.tnmeta.torymeta.model.unity.SwitchScene
import com.tnmeta.torymeta.seminar.model.SeminarEnterInfo
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.SeminarInfo
import com.tnmeta.torymeta.seminar.model.ToryLoungeInfo
import com.tnmeta.torymeta.unity.ToryMetaWorldFragment
import com.tnmeta.torymeta.unity.unitycall.NativeSendUnity
import com.tnmeta.torymeta.unity.unitycall.UnityNativeCallEtc
import com.unity3d.player.UnityPlayer
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


/**
 * Fragment Super Class
 */
open class BaseFragment: Fragment() {
    companion object {
        val TAG : String = BaseFragment::class.java.simpleName

        fun newInstance() =
            BaseFragment().apply {}
    }

    val toryApplication: ToryApplication by lazy { ToryApplication.getInstance(requireActivity()) }
    val repository: ToryRepository by lazy { toryApplication.repository }

    protected fun firebaseAnalyticsMember(eventID : String) = try {
        Timber.tag(TAG).d("firebaseAnalyticsMember $eventID")
        FirebaseAnalytics.getInstance(requireContext()).apply {
            logEvent(eventID, Bundle().apply {
                putString(FirebaseParam.type, FirebaseParam.type_value)
                putString(FirebaseParam.member_id, repository.member.value!!.memberId.toString())
            })
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }

    protected fun firebaseAnalyticsID(eventID : String) = try {
        FirebaseAnalytics.getInstance(requireContext()).apply {
            logEvent(eventID, Bundle().apply {
                putString(FirebaseParam.type, FirebaseParam.type_value)
            })
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


    protected fun enterToryLounge(item : ToryLoungeInfo) = SwitchScene(
        url = item.videoUrl,
        roomType =  "",
        roomId =  "",
        roomTitle =  "",
        videoStartTime = "",
        isAppRelease =  Constants.IS_PRODUCTION_SERVER,
        scene = ToryMetaSceneParam.lobby,
        tableId = ""
    )


    protected fun enterToryLounge(item : ToryLoungeInfo, type : String ) = SwitchScene(
        url = item.videoUrl,
        roomType =  type,
        roomId =  "",
        roomTitle =  "",
        videoStartTime = "",
        isAppRelease =  Constants.IS_PRODUCTION_SERVER,
        scene = ToryMetaSceneParam.lobby,
        tableId = ""
    )

    protected fun enterSceneWorld(dataInfo : RoomInfoDto) = SwitchScene (
        url = "",
        roomType =  "",
        roomId =  "",
        roomTitle =  "",
        videoStartTime = "",
        isAppRelease =  Constants.IS_PRODUCTION_SERVER,
        scene = dataInfo.uniCode,
        tableId = ""
    )



    /**
     * enterSwitchScene
     */
    protected fun enterSeminarRoom(item : SeminarEnterInfo, result : SeminarEnterResult) = SwitchScene (
        url = result.seminarUrl,
        roomType = result.roomId,
        roomId = result.unitySeminarId,
        roomTitle = item.title,
        videoStartTime = item.startAt,
        isAppRelease = Constants.IS_PRODUCTION_SERVER,
        scene = ToryMetaSceneParam.seminar,
        tableId = ""
    )


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


    private fun onInitAvatarView() = try {
        Timber.d("onSendToNative onInitAvatarView")

        val valueParam = SwitchScene(
            url = "",
            roomType = "",
            roomId = "",
            roomTitle = "",
            videoStartTime = "",
            isAppRelease = Constants.IS_PRODUCTION_SERVER,
            scene = ToryMetaSceneParam.AvatarView,
            tableId = ""
        )
        sendNativeUnityMessage(ToryMetaMessageType.SwitchScene, valueParam)

    }catch (e : Exception){
        Timber.d(e.message)
    }

    /**
     * initSetAvatar
     */
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
     * onCharacterSet()
     */
    protected fun onCharacterSet(item : String, color : String) = try {
        Timber.d("characterSet $item - $color")

        repository.apply {
            val values = CharacterSet(
                characterId = myAvatarAttr.value!!.bodyCode,
                item = item,
                color = color
            )
            sendNativeUnityMessage(type = ToryMetaMessageType.CharacterSet,
                                    valueParam = values)
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }

    /**
     * sendNativeUnityMessage
     */
    protected fun sendNativeUnityMessage(type : String, valueParam : Any?) = try {

        CoroutineScope(Dispatchers.Main).launch {
            val messageInfo = UnitMessageInfo(
                type = type,
                value = valueParam
            )

            val params = BaseParam(messageInfo).parameter.toString()

            Timber.tag(TAG).d("sendNativeUnityMessage $params")

            UnityPlayer.UnitySendMessage(
                                    ToryMetaCallObject.NativeManager.trim(),
                                    ToryMetaCallFunction.SendToUnity.trim(),
                                    params )
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }


    protected fun requireMember() = try {
        Timber.tag(UnityNativeCallEtc.TAG).d("requireMember start")
        repository.apply {
            val member = repository.member.value

            val valueParam = PassMember(
                memberId    =   member!!.memberId.toInt(),
                imgUrl      =   member!!.imgUrl,
                birth       =   member!!.birth,
                emailId     =   member!!.emailId,
                name        =   member!!.name,
                phoneNum    =   member!!.phoneNum,
                profileName =   member!!.profileName,
                status      =   "",
                universityCode = member!!.universityCode,
                locationExposeYn = member!!.locationExposeYn,
                certUniYn   =   member!!.certUniYn
            )

            sendNativeUnityMessage(
                type = ToryMetaMessageType.PassMember,
                valueParam = valueParam
            )
        }

    }catch (e : Exception){
        Timber.tag(UnityNativeCallEtc.TAG).d("requireMember $e.message")
    }


    protected fun onAwake() = try {
        onInitAvatarView()
    }catch (e : Exception){
        Timber.d(e.message)
    }


}