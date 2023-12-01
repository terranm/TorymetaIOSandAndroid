package com.tnmeta.torymeta.campus.viewmodel

import android.location.Location
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import com.google.gson.JsonObject
import com.naver.maps.geometry.LatLng
import com.tnmeta.torymeta.api.ApiMode
import com.tnmeta.torymeta.base.BaseViewModel
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.model.event.EventType
import com.tnmeta.torymeta.model.event.LocationInfoEventBus
import com.tnmeta.torymeta.main.model.RoomInfoDto
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.model.dto.BBSNoticeDTO
import com.tnmeta.torymeta.model.dto.LocationInfoDTO
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.kotlin.subscribeBy
import org.greenrobot.eventbus.EventBus
import timber.log.Timber
import java.util.*

class CampusViewModel: BaseViewModel() {
    companion object {
        const val TAG = "CampusViewModel"
    }

    val friendMarkerList = repository.friendMarkerList
    private var updateFriendMarkerScheduler: Timer? = null

    private val _myLocation = MutableLiveData<LatLng>()
    val myLocation: LiveData<LatLng> = _myLocation


    private val _currentPosition: MutableLiveData<Int> = MutableLiveData()
    val currentPosition: LiveData<Int>
        get() = _currentPosition


    fun isShowSeminarPopup() = repository.isShowSeminarPopup
    fun isShowSeminarOnAirButton() = repository.isShowSeminarOnAirButton
    fun getSeminarDetail(uiMode: ApiMode.UIMode) = repository.getSeminarDetail(uiMode)
    fun getFriend(uiMode: ApiMode.UIMode, friendId: Long) = repository.getFriend(uiMode, friendId)

    fun updatePoint() = repository.updatePoint(ApiMode.UIMode.NONE)

    val point = repository.point

    val myAvatarAttr = repository.myAvatarAttr

    init {
        // 10초 간격으로 친구 마커를 업데이트합니다
        val interval = 1000L * 10
        updateFriendMarkerScheduler = kotlin.concurrent.timer(period = interval) {
            //repository.getFriendMarkerList(ApiMode.UIMode.NONE)
        }

        // 최초 호출
        repository.getFriendMarkerList(ApiMode.UIMode.NONE)

        _currentPosition.value=0
    }

    override fun onCleared() {
        updateFriendMarkerScheduler?.cancel()
        updateFriendMarkerScheduler = null

        super.onCleared()
    }

    fun setCurrentPosition(position: Int){
        _currentPosition.value = position
    }

    fun getcurrentPosition() = currentPosition.value


    /**
     * 내 위치 공유 여부를 업데이트합니다
     */
    fun updateMyLocationShared(uiMode: ApiMode.UIMode, isLocationShared: Boolean) {
        repository.updateMyLocationShared(uiMode, isLocationShared)
    }

    /**
     * 내 좌표를 업데이트합니다
     */
    fun updateMyLocation(loc: LatLng) {
        try {
            Timber.d("updateMyLocation$loc")

            if (loc == null && (loc.latitude <= 0 || loc.longitude <= 0))
                return

            // 이전 좌표와 5M 이상 차이나는지 체크
            val updateMinDist = 5
            if (_myLocation.value != null) {
                val oldLoc = Location("old")
                oldLoc.apply {
                    latitude = _myLocation.value!!.latitude
                    longitude = _myLocation.value!!.longitude
                }

                val newLoc = Location("new")
                newLoc.apply {
                    latitude = loc.latitude
                    longitude = loc.longitude
                }

                val dist = oldLoc.distanceTo(newLoc)
                if (dist < updateMinDist) {
                    return
                }
            }

            _myLocation.value = loc
            repository.updateMyLocation(loc, member.value!!.isLocationShared)
                .subscribeBy(onNext = { data ->
                    val isValue = Gson().fromJson(data.toString(), LocationInfoDTO::class.java)
                    EventBus.getDefault().post(LocationInfoEventBus(EventType.LOCATION_INFO, if (isValue.isInRange == "Y") 1 else 0))

                })
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    private val _noticeList = MutableLiveData<List<BBSNoticeDTO>>()
    val noticeList: LiveData<List<BBSNoticeDTO>> = _noticeList

    fun getNoticeList(): Observable<List<BBSNoticeDTO>> {
        return repository.getNoticeList().apply {
            subscribeBy(onNext = {
                _noticeList.value = it
            }, onError = {}, onComplete = {})
        }
    }


    private val _liveSeminarList = MutableLiveData<List<SeminarDto>>()
    val liveSeminarList: LiveData<List<SeminarDto>> = _liveSeminarList

    fun getLiveSeminarList(): Observable<List<SeminarDto>> {
        return repository.getLiveSeminar().apply {
            subscribeBy(onNext = {
                _liveSeminarList.value = it
            }, onError = {}, onComplete = {})
        }
    }

    fun setProfileName(json : JsonObject) = repository.setProfileName(json)

    private val _recommandList = MutableLiveData<List<RoomInfoDto>>()
    val recommandList: LiveData<List<RoomInfoDto>> = _recommandList

    fun getRecommandMeta() : Observable<List<RoomInfoDto>> {
        return repository.getRecommandMeta().apply {
            subscribeBy(onNext = {
                _recommandList.value = it
            }, onError = {}, onComplete = {})
        }
    }

    fun setSeminarEnter(roomId : Int, json: JsonObject) = repository.setSeminarEnter(roomId, json)

    fun setParticipate(roomId: Int) = repository.setParticipate(roomId)




    private val _liveChattingList = MutableLiveData<List<ChattingRoom>>()
    val liveChattingList: LiveData<List<ChattingRoom>> = _liveChattingList

    fun getChattingList(json : JsonObject) : Observable<List<ChattingRoom>> {
        return repository.getChattingList(json).apply {
            subscribeBy(onNext =  {
                Timber.tag(TAG).d("getChattingList %s", it)

                _liveChattingList.value = it
                Timber.tag(TAG).d("getChattingList " + liveChattingList.value)
            }, onError = {

            }, onComplete = {

            } )
        }
    }

}