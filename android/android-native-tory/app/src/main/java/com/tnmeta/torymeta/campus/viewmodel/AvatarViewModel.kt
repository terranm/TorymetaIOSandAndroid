package com.tnmeta.torymeta.campus.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.JsonObject
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarColorDTO
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarModelingDTO
import com.tnmeta.torymeta.model.dto.myAvatar.WholeModelDTO
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber

class AvatarViewModel : BaseViewModel() {
    companion object {
        const val TAG = "AvatarViewModel"
    }

    private val _avatarList = MutableLiveData<List<WholeModelDTO>>()
    var avatarList:    LiveData<List<WholeModelDTO>> = _avatarList

    private val _avatarCategoryList = MutableLiveData<List<AvatarModelingDTO>>()
    var avatarCategoryList : LiveData<List<AvatarModelingDTO>> = _avatarCategoryList

    private val _avatarColorList = MutableLiveData<List<AvatarColorDTO>>()
    var avatarColorList : LiveData<List<AvatarColorDTO>> = _avatarColorList

    val point = repository.point

    fun getWholeModelingAvatar() {
        repository.getWholeModelingAvatar().apply {
            subscribeBy(onNext = { it ->
                _avatarList.value = it
                Timber.d("getWholeModelingAvatar $_avatarList")
            }, onError = {}, onComplete = {})
        }
    }

    fun getAvatarCategory(category : String) {
        Timber.tag(TAG).d("getAvatarCategory %s", category)
        repository.getAvatarCategory(category).apply {
            subscribeBy(onNext = {
                _avatarCategoryList.value = it

                Timber.d("getAvatarCategory ${_avatarCategoryList.value}")

            }, onError = {}, onComplete = {})
        }
    }

    fun getAvatarColor(category: String) {
        repository.getAvatarColor(category).apply {
            subscribeBy(onNext = {
                _avatarColorList.value = it

                Timber.d("getAvatarCategory $_avatarColorList")

            }, onError = {}, onComplete = {})
        }
    }

    /**
     * 아바타 저장
     */
    fun avatarSave(jsonObject: JsonObject) = repository.avatarSave(jsonObject)

    /**
     * 아바타 아이템 확인
     */
    fun isOwned(jsonObject: JsonObject) = repository.isOwned(jsonObject)

    /**
     *  아바타 구매 후, 저장
     */
    fun avatarBuy(jsonObject: JsonObject) = repository.avatarBuy(jsonObject)


}