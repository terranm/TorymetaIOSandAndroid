package com.tnmeta.torymeta.seminar.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.seminar.model.seminar.SeminarContentResult
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy

class MyCreateViewModel : BaseViewModel() {

    companion object {
        const val TAG = "MyCreateViewModel"
    }

    override fun onCleared() {
        super.onCleared()
    }


    private val _seminarList = MutableLiveData<SeminarContentResult>()
    val seminarList: LiveData<SeminarContentResult> = _seminarList

    fun getCreateSeminar() : Observable<SeminarContentResult> {
        return repository.getCreateSeminar().apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }


    fun getCreateSeminar(lastid : Int) : Observable<SeminarContentResult> {
        return repository.getCreateSeminar(lastid).apply {
            subscribeBy(onNext = {
                _seminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }

    fun deleteMySeminar(id : Int) = repository.deleteMySeminar(id)

}