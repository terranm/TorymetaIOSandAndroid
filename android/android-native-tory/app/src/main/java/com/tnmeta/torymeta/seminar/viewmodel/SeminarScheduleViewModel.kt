package com.tnmeta.torymeta.seminar.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.main.model.SeminarDto
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy

class SeminarScheduleViewModel : BaseViewModel() {

    companion object {
        const val TAG = "SeminarScheduleViewModel"
    }


    private val _seminarArray = MutableLiveData<List<SeminarDto>>()
    val seminarArray: LiveData<List<SeminarDto>> = _seminarArray


    fun getDateSeminar(searchDate : String) : Observable<List<SeminarDto>> {
        return repository.getDateSeminar(searchDate).apply {
            subscribeBy(onNext = {
               _seminarArray.value = it
            }, onError = {}, onComplete = {})
        }

    }


}