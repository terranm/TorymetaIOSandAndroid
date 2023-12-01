package com.tnmeta.torymeta.seminar.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.seminar.model.detail.SeminarDetailDto
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy

class SeminarInfoDetailViewModel : BaseViewModel() {

    companion object {
        const val TAG = "SeminarInfoDetailViewModel"
    }

    private val _seminarInfo = MutableLiveData<SeminarDetailDto>()
    val seminarInfo: LiveData<SeminarDetailDto> = _seminarInfo


    override fun onCleared() {
        super.onCleared()
    }


    fun getSeminarDetailInfo(id : Int) : Observable<SeminarDetailDto> {
        return repository.getSeminarDetail(id).apply {
            subscribeBy(onNext = {
                _seminarInfo.value = it
            }, onError = {}, onComplete = {})
        }
    }

}