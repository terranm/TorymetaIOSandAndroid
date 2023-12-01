package com.tnmeta.torymeta.unity.unitycall

import android.app.Activity
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.LoungeVideoUrl
import com.tnmeta.torymeta.model.unity.PassMember
import com.tnmeta.torymeta.model.unity.VideoUrl
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


/**
 * UnityNativeCallEtc
 */
class UnityNativeCallEtc : Any() {

    companion object {
        val TAG : String = UnityNativeCallEtc::class.java.simpleName

        @JvmStatic
        val instance by lazy { UnityNativeCallEtc() }
    }

    /**
     * requireLoungeVideoUrl
     * @param currentActivity
     */
    fun requireLoungeVideoUrl(currentActivity: Activity) = try {
        val repository = ToryApplication.getRepository(currentActivity)

        repository.apply {
            val params = BaseParam(
                VideoUrl(
                    loungeType = "LOUNGE",
                    mediaType = "mp4")).parameter

            getVideoUrl(json = params).subscribeBy(onNext = {
                CoroutineScope(Dispatchers.Main).launch {

                    val valueParam = LoungeVideoUrl(url = it.videoUrl)

                    NativeSendUnity.instance.onNativeSendToUnity(
                        typeParam = ToryMetaMessageType.LoungeVideoUrl,
                        valueParam = valueParam
                    )
                }
            }, onError = {})
        }

    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


    /**
     * requireMember
     *
     * @param currentActivity
     */
    fun requireMember(currentActivity: Activity) = try {
        Timber.tag(TAG).d("requireMember start")

        val repository = ToryApplication.getRepository(currentActivity)

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

            Timber.tag(TAG).d("requireMember $valueParam")

            NativeSendUnity.instance.onNativeSendToUnity(
                                typeParam = ToryMetaMessageType.PassMember,
                                valueParam = valueParam
            )
        }

    }catch (e : Exception){
        Timber.tag(TAG).d("requireMember $e.message")
    }

}