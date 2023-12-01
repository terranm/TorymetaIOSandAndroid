package com.tnmeta.torymeta.chattinglounge.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.JsonObject
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.model.FriendsInfo
import com.tnmeta.torymeta.model.MemberInfo
import com.tnmeta.torymeta.model.result.ApiResponse
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy
import timber.log.Timber


class ChattingInviteViewModel : BaseViewModel() {

    companion object {
        val  TAG : String = ChattingInviteViewModel::class.java.simpleName
    }

    private val _friendList = MutableLiveData<List<MemberInfo>>()
    val friendList: LiveData<List<MemberInfo>> = _friendList

    fun getFriendsInfo(json: JsonObject) : Observable<ApiResponse<FriendsInfo>> {
        return repository.getFriendsInfo(json).apply {
            subscribeBy(onNext =  {

                try {
                    val listArray = ArrayList<MemberInfo>()
                    listArray.apply {
                        //addAll(it.result!!.newFriendList)
                        addAll(it.result!!.currentFriendList)
                        //addAll(it.result!!.acceptWaitFriendList)
                        //addAll(it.result!!.friendListInRange)
                        //addAll(it.result!!.friendListOutRange)
                    }
                    Timber.d("getFriendsInfo ${listArray.size} + $listArray")

                    _friendList.value = listArray

                }catch (e : Exception){
                    Timber.d("getFriendsInfo ${e.message}")
                }


            }, onError = {}, onComplete = {} )
        }
    }


    fun pushChatInvite(json: JsonObject) = repository.pushChatInvite(json)

}