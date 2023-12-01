package com.tnmeta.torymeta.my_page

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.model.dto.MyCommentDTO
import com.tnmeta.torymeta.model.dto.MyWriteDTO
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy

class MyPageViewModel: BaseViewModel() {
    companion object {
        const val TAG = "MyPageViewModel"
    }

    val point = repository.point
    fun updatePoint() = repository.updatePoint(ApiMode.UIMode.NONE)

    private val _myWirteList = MutableLiveData<List<MyWriteDTO>>()
    private val _myCommentList = MutableLiveData<List<MyCommentDTO>>()

    val myWirteList: LiveData<List<MyWriteDTO>> = _myWirteList
    val myCommentList: LiveData<List<MyCommentDTO>> = _myCommentList

    /**
     * 내가 쓴 글 목록을 가져옵니다
     */
    fun getMyWriteList(uiMode: ApiMode.UIMode = ApiMode.UIMode.NONE): Observable<List<MyWriteDTO>> {
        return repository.getMyWriteList(uiMode).apply {
            subscribeBy(onNext = {
                _myWirteList.value = it
            }, onError = {}, onComplete = {})
        }
    }

    /**
     * 내가 쓴 댓글 목록을 가져옵니다
     */
    fun getMyCommentList(uiMode: ApiMode.UIMode = ApiMode.UIMode.NONE): Observable<List<MyCommentDTO>> {
        return repository.getMyCommentList(uiMode).apply {
            subscribeBy(onNext = {
                _myCommentList.value = it
            }, onError = {}, onComplete = {})
        }
    }
}