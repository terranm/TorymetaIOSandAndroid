package com.tnmeta.torymeta.seminar.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.JsonObject
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.main.model.RoomInfoDto
import com.tnmeta.torymeta.model.result.SimpleResult
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy

class SeminarViewModel : BaseViewModel() {

    companion object {
        const val TAG = "SeminarViewModel"
    }

    init {
    }

    override fun onCleared() {
        super.onCleared()
    }

    private val _seminarRoomList = MutableLiveData<List<RoomInfoDto>>()
    val seminarRoomList: LiveData<List<RoomInfoDto>> = _seminarRoomList


    fun getRoomInfo(roomSize : String) : Observable<List<RoomInfoDto>> {
        return repository.getRoomInfo(roomSize).apply {
            subscribeBy(onNext = {
                _seminarRoomList.value = it
            }, onError = {}, onComplete = {})
        }
    }

    fun setSeminar(json : JsonObject) = repository.setSeminar(json)

    fun updateSeminar(id : Int, json : JsonObject) = repository.updateSeminar (id, json)


}