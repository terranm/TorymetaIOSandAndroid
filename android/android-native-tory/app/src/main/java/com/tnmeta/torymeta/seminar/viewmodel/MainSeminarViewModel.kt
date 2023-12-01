package com.tnmeta.torymeta.seminar.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.seminar.model.seminar.SeminarContentResult
import com.tnmeta.torymeta.utils.DateFormatter
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy
import java.util.Calendar

class MainSeminarViewModel : BaseViewModel() {

    companion object {
        const val TAG = "MainSeminarViewModel"
    }

    init {
    }

    override fun onCleared() {
        super.onCleared()
    }

    private val _seminarList = MutableLiveData<SeminarContentResult>()
    val seminarList: LiveData<SeminarContentResult> = _seminarList

    fun getSeminar() : Observable<SeminarContentResult> {
        return repository.getSeminar().apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }

    fun getSeminar(lastid : Int) : Observable<SeminarContentResult> {
        return repository.getSeminar(lastid).apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
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