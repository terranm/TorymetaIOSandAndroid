package com.tnmeta.torymeta.seminar.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.seminar.model.seminar.SeminarContentResult
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy

class MySubScriptionViewModel : BaseViewModel() {

    companion object {
        const val TAG = "MySubScriptionViewModel"
    }

    override fun onCleared() {
        super.onCleared()
    }

    private val _seminarList = MutableLiveData<SeminarContentResult>()
    val seminarList: LiveData<SeminarContentResult> = _seminarList

    fun getParticipationSeminar() : Observable<SeminarContentResult> {
        return repository.getParticipationSeminar().apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }


    fun getParticipationSeminar(id : Int) : Observable<SeminarContentResult> {
        return repository.getParticipationSeminar(id).apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }

}