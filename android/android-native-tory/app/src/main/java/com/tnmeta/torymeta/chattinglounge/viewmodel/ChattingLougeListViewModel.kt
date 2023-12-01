package com.tnmeta.torymeta.chattinglounge.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.JsonObject
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber

class ChattingLougeListViewModel : BaseViewModel() {

    companion object {
        val TAG = ChattingLougeListViewModel::class.java
    }

    private val _liveChattingList = MutableLiveData<List<ChattingRoom>>()
    val liveChattingList: LiveData<List<ChattingRoom>> = _liveChattingList

    /**
     * getChattingList
     */
    fun getChattingList(json : JsonObject) : Observable<List<ChattingRoom>> {
        return repository.getChattingList(json).apply {
            subscribeBy(onNext =  {
                _liveChattingList.value = it
                Timber.tag(CampusViewModel.TAG).d(" getChattingList " + liveChattingList.value)
            }, onError = {}, onComplete = {} )
        }
    }


}