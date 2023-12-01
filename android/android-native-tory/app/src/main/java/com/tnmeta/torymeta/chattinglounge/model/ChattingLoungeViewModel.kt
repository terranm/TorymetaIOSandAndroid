package com.tnmeta.torymeta.chattinglounge.model

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.JsonObject
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber

class ChattingLoungeViewModel : BaseViewModel()  {

    companion object {
        const val TAG = "ChattingLoungeViewModel"
    }

    private val _liveChattingList = MutableLiveData<List<ChattingRoom>>()
    val liveChattingList: LiveData<List<ChattingRoom>> = _liveChattingList

    fun getChattingList(json : JsonObject) : Observable<List<ChattingRoom>> {
        return repository.getChattingList(json).apply {
            subscribeBy(onNext =  {
                _liveChattingList.value = it
                Timber.tag(TAG).d("getChattingList " + liveChattingList.value)
            }, onError = {}, onComplete = {} )
        }
    }


}