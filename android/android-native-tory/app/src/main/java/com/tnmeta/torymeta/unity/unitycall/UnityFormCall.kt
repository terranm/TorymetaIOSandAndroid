package com.tnmeta.torymeta.unity.unitycall

import android.app.Activity
import android.content.Intent
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.google.gson.JsonParser
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.chattinglounge.ChattingLougeListActivity
import com.tnmeta.torymeta.chattinglounge.ChattingLoungeCreateActivity
import com.tnmeta.torymeta.chattinglounge.ChattingLoungeReportActivity
import com.tnmeta.torymeta.chattinglounge.ParticipantsListActivity
import com.tnmeta.torymeta.chattinglounge.dialog.ChattingPasswordDialog
import com.tnmeta.torymeta.chattinglounge.dialog.ParticipantMenuDialog
import com.tnmeta.torymeta.chattinglounge.model.MenuType
import com.tnmeta.torymeta.chattinglounge.model.ParticipantMenu
import com.tnmeta.torymeta.common.ChattingAction
import com.tnmeta.torymeta.common.FormType
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.FriendChangeStatus
import com.tnmeta.torymeta.model.unity.FormCall
import com.tnmeta.torymeta.model.unity.ParticipantsMenuOption
import com.tnmeta.torymeta.model.unity.PasswordInput
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.unity3d.player.UnityPlayer
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber


class UnityFormCall : Any() {
    companion object {
        val TAG : String = UnityFormCall::class.java.simpleName

        @JvmStatic
        val instance by lazy { UnityFormCall() }
    }


    /**
     * onFormCall
     */
    fun onFormCall(currentActivity: Activity, jsonString: String) {
        try {
            val valueJsonElement = JsonParser.parseString(jsonString).asJsonObject.get("value")
            if(valueJsonElement.isJsonNull)
                return

            val valueJsonObject = valueJsonElement.asJsonObject

            val formValue = Gson().fromJson(valueJsonObject, FormCall::class.java)

            Timber.tag(TAG).d("onFormCall ${formValue.form} - ${formValue.option}")


            when (formValue.form) {
                FormType.PasswordInput -> onPassword(currentActivity = currentActivity,
                                                            option = formValue.option)

                FormType.ChatCreate -> onChatLoungeCreate(currentActivity = currentActivity,
                                                                option = formValue.option)

                FormType.ChatList -> onChattingList(currentActivity = currentActivity,
                                                    option = formValue.option)

                FormType.ParticipantsMenu -> onParticipantsMenu(currentActivity = currentActivity,
                                                                option = formValue.option )

                FormType.ParticipantsList -> onParticipantsList(currentActivity = currentActivity,
                                                                option = formValue.option)

                FormType.InvitableList -> onRequestInvitable(currentActivity = currentActivity,
                                                                    jsonValue = jsonString)


                else -> {}
            }

        } catch (e: Exception) {
            Timber.d("onFormCall $e.message")
        }
    }


    /**
     * onChatLoungeCreate
     */
    private fun onChatLoungeCreate(currentActivity: Activity, option: JsonElement) = try {
        val intent = Intent(UnityPlayer.currentActivity.applicationContext, ChattingLoungeCreateActivity::class.java)
        currentActivity.startActivity(intent)
    }catch (e : Exception){
        Timber.d("FormCall $e.message")
    }


    /**
     * onParticipantsMenu
     */
    private fun onParticipantsMenu(currentActivity: Activity, option : JsonElement ) = try {
        val optionValue = Gson().fromJson(option.toString(), ParticipantsMenuOption::class.java)
        optionValue.apply {
            ParticipantMenuDialog.Builder(currentActivity, optionValue.roomMaker).apply {
                setCancelable(true)
                onClickListener = {

                    when ((it as ParticipantMenu).type) {
                        MenuType.Kick -> NativeSendUnity.instance.onNativeSendToUnity(typeParam = ChattingAction.Kick,
                                                                                            valueParam = null)

                        MenuType.Mandate -> NativeSendUnity.instance.onNativeSendToUnity(typeParam = ChattingAction.Mandate,
                                                                                            valueParam = null)

                        MenuType.Silence -> NativeSendUnity.instance.onNativeSendToUnity(typeParam = ChattingAction.Silence,
                                                                                            valueParam = null)

                        MenuType.FriendRequest -> {
                            CommonAlertDialog.Builder(currentActivity)
                                .setCancelable(false)
                                .setMessage("선택한 사용자에게\n친구 요청을 하시겠습니까?")
                                .setPositiveButton(R.string.system_alert_btn_ok) {
                                    onSendRequestFriend(currentActivity, optionValue.memberId.toLong())
                                }
                                .setNegativeButton(R.string.system_alert_btn_cancel) {}
                                .show()
                        }

                        MenuType.Warning -> NativeSendUnity.instance.onNativeSendToUnity(typeParam = ChattingAction.Warning,
                                                                                            valueParam = null)

                        MenuType.Report -> onChattingReport(currentActivity = currentActivity,
                                                                option = optionValue.memberId)

                    }
                }
                show()
            }
        }
    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


    /**
     * onChattingReport
     */
    private fun onChattingReport(currentActivity: Activity, option : String) = try {
        val intent = Intent(UnityPlayer.currentActivity.applicationContext, ChattingLoungeReportActivity::class.java).putExtra(
            ChattingLoungeReportActivity.ReportMemberIDParam, option
        )
        currentActivity.startActivity(intent)
    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


    /**
     * onPassword()
     */
    private fun onPassword(currentActivity: Activity, option: JsonElement) = try {

        val passwordValue = Gson().fromJson(option.toString(), PasswordInput::class.java)
        Timber.tag(TAG).d("onFormCall ${passwordValue.password}")

        ChattingPasswordDialog.Builder(currentActivity, passwordValue.password).apply {
            setOnEnterClick {

                NativeSendUnity.instance.onNativeSendToUnity(typeParam = ChattingAction.ChatJoin,
                                                            valueParam = null)
            }
            show()
        }


    }catch (e : Exception){
        Timber.tag(TAG).d("onFormCall - $e.message")
    }


    /**
     * onChattingList
     */
    private fun onChattingList(currentActivity: Activity, option: JsonElement) = try {
        val intent = Intent(UnityPlayer.currentActivity.applicationContext, ChattingLougeListActivity::class.java)
        currentActivity.startActivity(intent)

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }



    private fun onParticipantsList(currentActivity: Activity, option: JsonElement) = try {
        val intent = Intent(UnityPlayer.currentActivity.applicationContext, ParticipantsListActivity::class.java).putExtra(
            ParticipantsListActivity.ParticipantsListParam, option.toString()
        )
        currentActivity.startActivity(intent)
    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


    private fun onRequestInvitable(currentActivity: Activity, jsonValue : String) = try {

        /*
        val intent = Intent(UnityPlayer.currentActivity.applicationContext, ChattingInviteActivity::class.java).putExtra(
            ChattingInviteActivity.InviteParam, jsonValue )
        currentActivity.startActivity(intent)
         */

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


//    /**
//     * onDoAction
//     */
//    private fun onCallUnityType(type: String, params : Any?) = try {
//        Timber.tag(TAG).d("onCallUnityType $type")
//
//        val messageInfo = UnitMessageInfo(
//            type = type,
//            value = params
//        )
//
//        val params = BaseParam(messageInfo).parameter.toString()
//
//        UnityPlayer.UnitySendMessage(
//            ToryMetaCallObject.NativeManager.trim(),
//            ToryMetaCallFunction.SendToUnity.trim(),
//            params
//        )
//
//    }catch (e : Exception){
//        Timber.tag(TAG).d(e.message)
//    }


    /**
     * onSendRequestFriend
     */
    private fun onSendRequestFriend(currentActivity: Activity, memberID : Long) = try {

        val repository = ToryApplication.getRepository(currentActivity)

        val params = BaseParam(
            FriendChangeStatus(
                target = "F",
                status = "R",
                friendId = memberID
            )).parameter

        repository.friendChangeStatus(params)
            .subscribeBy(onNext = { result ->
                if( result.result!!.isSucceed ) {
                    CommonAlertDialog.Builder(currentActivity)
                        .setMessage("정상적으로 친구요청을 하였습니다.")
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }
                else {
                    CommonAlertDialog.Builder(currentActivity)
                        .setMessage(result.resultMessage.toString())
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }
            }, onError = {})

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


}