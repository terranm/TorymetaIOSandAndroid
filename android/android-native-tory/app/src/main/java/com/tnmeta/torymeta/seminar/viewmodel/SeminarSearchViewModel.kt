package com.tnmeta.torymeta.seminar.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.seminar.model.seminar.SeminarContentResult
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy

class SeminarSearchViewModel : BaseViewModel()  {

    companion object {
        const val TAG = "SeminarSearchViewModel"
    }


    private val _seminarList = MutableLiveData<SeminarContentResult>()
    val seminarList: LiveData<SeminarContentResult> = _seminarList


    fun seminarSearch(query : String) : Observable<SeminarContentResult> {
        return repository.search(query).apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }

    fun seminarSearch(query : String, lastid : Int) : Observable<SeminarContentResult> {
        return repository.search(query, lastid).apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }

}