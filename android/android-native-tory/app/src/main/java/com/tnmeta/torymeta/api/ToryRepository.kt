package com.tnmeta.torymeta.api

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.naver.maps.geometry.LatLng
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.chattinglounge.model.ChattingRoom
import com.tnmeta.torymeta.chattinglounge.model.RoomsResult
import com.tnmeta.torymeta.common.LocalStorageKey
import com.tnmeta.torymeta.main.model.RoomInfoDto
import com.tnmeta.torymeta.main.model.SeminarDto
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.FriendsInfo
import com.tnmeta.torymeta.model.VideoResult
import com.tnmeta.torymeta.model.dto.*
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarColorDTO
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarModelingDTO
import com.tnmeta.torymeta.model.dto.myAvatar.MyAvatarAttr
import com.tnmeta.torymeta.model.dto.myAvatar.MyAvatarDTO
import com.tnmeta.torymeta.model.dto.myAvatar.WholeModelDTO
import com.tnmeta.torymeta.model.param.LocationInfoParam
import com.tnmeta.torymeta.model.result.*
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.detail.SeminarDetailDto
import com.tnmeta.torymeta.seminar.model.seminar.SeminarContentResult
import com.tnmeta.torymeta.talk.FriendListMap
import com.tnmeta.torymeta.talk.FriendListType
import com.tnmeta.torymeta.utils.extensions.Extensions.update
import com.tnmeta.torymeta.videoplayer.model.LectureResult
import com.tnmeta.torymeta.videoplayer.model.LectureVideoInfoResult
import com.tnmeta.torymeta.videoplayer.model.VideoInfoResult
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Observer
import io.reactivex.rxjava3.kotlin.subscribeBy
import io.reactivex.rxjava3.schedulers.Schedulers
import io.reactivex.rxjava3.subjects.PublishSubject
import okhttp3.MultipartBody
import timber.log.Timber

class ToryRepository {
    companion object {
        val TAG : String = ToryRepository::class.java.simpleName
    }

    private val api: Api = Client.default()
    private val nftApi: Api = Client.nft()
    private val messengerApi : Api = Client.messenger()
    private val metaBusApi   : Api = Client.metabus()
    private val apiVersion2 : Api = Client.apiVersion2()

    private val _member =           MutableLiveData<MemberDTO>()
    private val _point =            MutableLiveData<PointDTO>()
    lateinit var universityList:    List<UniversityDTO>
    lateinit var toryItemList:      List<ToryItemDTO>
    lateinit var defaultProfileList: List<String>
    var isShowSeminarPopup = false
    var isShowSeminarOnAirButton = false

    private var eventBannerUrl : String = ""
    lateinit var eventBannerList : ArrayList<EventBanner>

    private val campusMarkers = HashMap<String, List<MarkerDTO>>()
    private val markerDetails = HashMap<Int, MarkerDetailDTO>()

    var myContactPhoneList: List<String>? = null

    val eventArray = ArrayList<EventListDTO>()
    //val gameInfoArray = ArrayList<GameDTO>()

    private val _myAvatarAttr = MutableLiveData<MyAvatarAttr>()

    var hasAvatarAttrYn : String = ""
    var ttcStatus       : String = ""
    var isAvatarload : Boolean = false

    // Friend
    private val _friendListMap = MutableLiveData<FriendListMap>().apply {
        this.value = FriendListMap()

        FriendListType.values().forEach {
            this.value!![it] = mutableListOf()
        }
    }

    private val _friendMarkerList = MutableLiveData<List<MarkerDTOEnc>>()

    // as LiveData
    val member: LiveData<MemberDTO> = _member
    val point: LiveData<PointDTO> = _point
    val friendListMap: LiveData<FriendListMap> = _friendListMap
    val friendMarkerList: LiveData<List<MarkerDTOEnc>> = _friendMarkerList
    val myAvatarAttr    : LiveData<MyAvatarAttr> = _myAvatarAttr


    init {
    }

    /**
     * 로그아웃
     */
    fun signOut() {
        try {
            setLoginToken("")
            setAutoLogin(false)
            _member.postValue(null)
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    /**
     * 로그인 토큰을 저장합니다
     */
    fun setLoginToken(token: String) {
        ToryApplication.localStorage.setString(LocalStorageKey.WEB_VIEW_LOGIN_TOKEN, token)
    }

    fun getLoginToken(): String {
        return ToryApplication.localStorage.getString(LocalStorageKey.WEB_VIEW_LOGIN_TOKEN, "")
    }

    fun setAutoLogin(isAutoLogin: Boolean) {
        ToryApplication.localStorage.setBoolean(LocalStorageKey.WEB_VIEW_AUTO_LOGIN, isAutoLogin)
    }

    fun isAutoLogin(): Boolean  {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.WEB_VIEW_AUTO_LOGIN, false)
        //return Prefs.getBoolean(LocalStorageKey.WEB_VIEW_AUTO_LOGIN, false)
    }

    /**
     * FCM 토큰을 저장합니다
     */
    fun setFCMToken(token: String) {
        ToryApplication.localStorage.setString(LocalStorageKey.FCM_TOKEN, token)
    }

    fun getFCMToken(): String {
        return ToryApplication.localStorage.getString(LocalStorageKey.FCM_TOKEN, "")
    }

    /**
     * BC 토큰을 저장합니다
     */
    fun setBCToken(token: String) {
        ToryApplication.localStorage.setString(LocalStorageKey.WEB_VIEW_NFT_BC_TOKEN, token)
    }

    fun getBCToken(): String {
        return ToryApplication.localStorage.getString(LocalStorageKey.WEB_VIEW_NFT_BC_TOKEN, "")
    }

    /**
     * 캠퍼스 정보를 반환합니다
     */
    fun getCampus(code: String): UniversityDTO {
        return universityList.find {
            it.universityCode == code
        }!!
    }

    fun getMyCampus(): UniversityDTO {
        return getCampus(member.value!!.universityCode)
    }

    private fun <T> getObservable(observable: Observable<T>, type: ApiMode.UIMode): Observable<T> {
        val subject = PublishSubject.create<T>().apply {
            subscribe(DefaultObserver(type) as Observer<T>)
        }

        observable
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe(subject)

        return subject

//        return observable
//            .subscribeOn(Schedulers.io())
//            .observeOn(AndroidSchedulers.mainThread())
//            .apply {
//                subscribe(Api.Companion.LoadingViewObserver(type) as Observer<T>)
//            }
    }

    /**
     * 앱 버전을 체크합니다
     */
    fun checkVersion(version: String): Observable<VersionCheckResult> {
        return getObservable(api.checkVersion(version = version), ApiMode.UIMode.ALERT_RESTART)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * init api
     */
    @Deprecated("api 변경됨")
    fun initData(): Observable<InitDataResult> {
        return getObservable(api.initData(), ApiMode.UIMode.ONLY_LOADING)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { data ->
                    Log.i(TAG, "initData subscribe called! $data")

                    try {
                        _member.value = data.member
                        _point.value = PointDTO(data.point, data.mileage)

                        universityList = data.universityList

                        toryItemList = data.toryItemList.sortedBy {
                            it.itemValue
                        }
                        defaultProfileList = data.defaultProfileList
                        isShowSeminarPopup = data.isShowSeminarPopup
                        isShowSeminarOnAirButton = data.isShowSeminarOnAirButton

                        _myAvatarAttr.value = data.myAvatarAttr
                        eventBannerList = data.eventBannerList

                        //hasAvatarYn = data.hasAvatarYn
                        //_myAvatar.value = data.myAvatar

                    }catch (e : Exception){
                        Timber.d(e.message)
                    }

                }, onError = {})
            }
    }

    fun initData(json: JsonElement): Observable<InitDataResult> {
        return getObservable(api.initData(json), ApiMode.UIMode.ONLY_LOADING)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { data ->
                    try {

                        _member.value = data.member
                        _point.value = PointDTO(data.point, data.mileage)

                        universityList = data.universityList

                        toryItemList = data.toryItemList.sortedBy {
                            it.itemValue
                        }
                        defaultProfileList = data.defaultProfileList
                        isShowSeminarPopup = data.isShowSeminarPopup
                        isShowSeminarOnAirButton = data.isShowSeminarOnAirButton

                        eventBannerUrl = data.eventBannerUrl

                        hasAvatarAttrYn = data.hasAvatarAttrYn

                        _myAvatarAttr.value = data.myAvatarAttr
                        eventBannerList = data.eventBannerList

                        ttcStatus = data.ttcStatus

                    }catch (e : Exception){
                        Timber.d(e.message)
                    }

                }, onError = {})
            }
    }

    /**
     * 멤버 정보를 업데이트합니다
     */
    fun updateMember(uiMode: ApiMode.UIMode): Observable<MemberDTO> {
        return getObservable(api.getMember(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { data ->
                    _member.value = data
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 포인트 정보를 업데이트합니다
     */
    fun updatePoint(uiMode: ApiMode.UIMode): Observable<PointDTO> {
        return getObservable(api.getPoint(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { data ->
                    _point.value = data
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 세미나 상세 정보를 가져옵니다
     */
    fun getSeminarDetail(loadingType: ApiMode.UIMode): Observable<SeminarDetailResult> {
        return getObservable(api.getSeminarDetail(), loadingType)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * 프로필을 업데이트합니다
     */
    fun updateProfileImage(file: MultipartBody.Part): Observable<UpdateProfileResult> {
        return getObservable(api.updateProfileImage(listOf(file)), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { result ->
                    if( result.uploadSuccessYn == "Y" ) {
                        _member.update {
                            it.imgUrl = result.imgUrl
                        }
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 캠퍼스를 설정합니다
     */
    fun updateCampus(universityCode: String, loadingType: ApiMode.UIMode): Observable<UpdateCampusResult> {
        return getObservable(api.updateCampus(universityCode), loadingType)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { result ->
                    _member.update { data ->
                        data.universityCode = universityCode
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 포인트를 충전합니다
     */
    fun chargePoint(packageName: String, productId: String, purchaseToken: String): Observable<ChargePointResult> {
        val params = mapOf(
            "packageName" to packageName,
            "productId" to productId,
            "purchaseToken" to purchaseToken,
        )

        return getObservable(api.chargePoint(Gson().toJsonTree(params)), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { data ->
                    _point.update {
                        it.point = data.point
                        it.mileage = data.mileage
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 내 위치 공유 여부를 업데이트합니다
     */
    fun updateMyLocationShared(uiMode: ApiMode.UIMode, isLocationShared: Boolean): Observable<SimpleResult> {
        val params = mapOf(
            "locationExposeYn" to if(isLocationShared) "Y" else "N"
        )

        return getObservable(api.updateMyLocationShared(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { result ->
                    if( result.isSucceed ) {
                        _member.update {
                            it.isLocationShared = isLocationShared
                        }
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 내 좌표를 업데이트합니다
     */
    fun updateMyLocation(loc: LatLng, isLocationShared: Boolean): Observable<Any> {

        val param = BaseParam(LocationInfoParam(loc.latitude,
                                                loc.longitude,
                                                if(isLocationShared) "Y" else "N",
                                                member.value!!.universityCode)).parameter

        Timber.tag(TAG).d("updateMyLocation - $param")
        return getObservable(api.updateMyLocation(param), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * 캠퍼스 건물 정보를 가져옵니다
     */
    fun getCampusBuildingMarker(universityCode: String): Observable<List<MarkerDTO>> {
        if( campusMarkers.containsKey(universityCode) ) {
            return Observable.just(campusMarkers[universityCode])
        }

        return getObservable(api.getCampusBuildingMarker(universityCode), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.markerList
            }
            .apply {
                subscribeBy(onNext = {
                    campusMarkers[universityCode] = it
                }, onError = {}, onComplete = {})
            }
    }

    fun getMyCampusBuildingMarker(): Observable<List<MarkerDTO>> {
        Log.i(TAG, "getMyCampusBuildingMarker: ${member.value}")
        return getCampusBuildingMarker(member.value!!.universityCode)
    }

    /**
     * 친구 마커 정보를 가져옵니다
     */
    //fun getFriendMarkerList(uiMode: ApiMode.UIMode): Observable<List<MarkerDTO>> {
    fun getFriendMarkerList(uiMode: ApiMode.UIMode): Observable<List<MarkerDTOEnc>> {
        return getObservable(api.getFriendMarkerListEnc(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.markerList
            }
            .apply {
                subscribeBy(onNext = {
                    _friendMarkerList.value = it
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 마커 상세 정보를 가져옵니다
     */
    fun getMarkerDetail(markerId: Int): Observable<MarkerDetailDTO> {
        if( markerDetails.containsKey(markerId) ) {
            return Observable.just(markerDetails[markerId])
        }

        return getObservable(api.getMarkerDetail(markerId), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = {
                    markerDetails[markerId] = it
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 내가 쓴 글 목록을 가져옵니다
     */
    fun getMyWriteList(uiMode: ApiMode.UIMode): Observable<List<MyWriteDTO>> {
        return getObservable(api.getMyWriteList(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.list
            }
    }

    /**
     * 내가 쓴 댓글 목록을 가져옵니다
     */
    fun getMyCommentList(uiMode: ApiMode.UIMode): Observable<List<MyCommentDTO>> {
        return getObservable(api.getMyCommentList(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.list
            }
    }

    /**
     * 친구 정보를 가져옵니다
     */
    fun getFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<FriendDTO> {
        return getObservable(api.getFriend(friendId), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * 친구 데이터를 가져옵니다
     */
    fun getCacheFriendDataList(type: FriendListType): List<FriendDTO> {
        val map = _friendListMap.value ?: return listOf()
        return map[type]!!
    }

    fun getCacheFriendData(type: FriendListType, findFunc: (FriendDTO) -> Boolean): FriendDTO? {
        return getCacheFriendDataList(type).find {
            findFunc(it)
        }
    }

    /**
     * 알 수도 있는 친구 목록을 가져옵니다
     */
    fun getFriendMayKnowList(uiMode: ApiMode.UIMode, phoneList: List<String> = myContactPhoneList!!): Observable<List<FriendDTO>> {
        val params = mapOf(
            "phoneList" to phoneList
        )

        return getObservable(api.getFriendMayKnowList(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.list
            }
            .apply {
                subscribeBy(onNext = { list ->
                    _friendListMap.update { value ->
                        value[FriendListType.NEW] = list.toMutableList()
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 받은 친구 요청 목록을 가져옵니다
     */
    fun getFriendRequestList(uiMode: ApiMode.UIMode): Observable<List<FriendDTO>> {
        return getObservable(api.getFriendRequestList(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.list
            }
            .apply {
                subscribeBy(onNext = { list ->
                    _friendListMap.update { value ->
                        value[FriendListType.REQUEST] = list.toMutableList()
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 친구 목록을 가져옵니다
     */
    fun getFriendList(uiMode: ApiMode.UIMode): Observable<FriendListResult> {
        return getObservable(api.getFriendList(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = {
                    _friendListMap.update { value ->
                        value[FriendListType.CAMPUS] = it.inRangeList.toMutableList()
                        value[FriendListType.UNKNOWN_LOCATION] = it.outRangeList.toMutableList()
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 차단한 친구 목록을 가져옵니다
     */
    fun getFriendBlockList(uiMode: ApiMode.UIMode): Observable<List<FriendDTO>> {
        return getObservable(api.getFriendBlockList(), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.list
            }
            .apply {
                subscribeBy(onNext = { list ->
                    _friendListMap.update { value ->
                        value[FriendListType.BLOCK] = list.toMutableList()
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 친구 요청
     */
    fun sendRequestFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<SimpleResult> {
        val params = mapOf(
            "friendId" to friendId
        )

        return getObservable(api.requestFriend(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { result ->
                    if( !result.isSucceed ) {
                        return@subscribeBy
                    }

                    _friendListMap.update {
                        val friendData = getCacheFriendData(FriendListType.NEW) { it ->
                            it.memberId == friendId
                        }

                        friendData?.let {
                            it.sendRequest()
                        }
                    }
                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 친구 요청 수락
     */
    fun acceptFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<SimpleResult> {
        val params = mapOf(
            "friendId" to friendId
        )

        return getObservable(api.acceptFriend(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * 친구 차단
     */
    fun blockFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<SimpleResult> {
        val params = mapOf(
            "friendId" to friendId
        )

        return getObservable(api.blockFriend(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
            .apply {
                subscribeBy(onNext = { result ->
                    if( !result.isSucceed ) {
                        return@subscribeBy
                    }

//                    _friendListMap.update {
//                        (getCacheFriendDataList(FriendListType.CAMPUS) as MutableList).removeIf { it ->
//                            it.memberId == friendId
//                        }
//                        (getCacheFriendDataList(FriendListType.UNKNOWN_LOCATION) as MutableList).removeIf { it ->
//                            it.memberId == friendId
//                        }
//
//                        val data = getCacheFriendData()
//                    }

                }, onError = {}, onComplete = {})
            }
    }

    /**
     * 친구 차단 해제
     */
    fun unblockFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<SimpleResult> {
        val params = mapOf(
            "friendId" to friendId
        )

        return getObservable(api.unblockFriend(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * 친구 삭제
     */
    fun deleteFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<SimpleResult> {
        val params = mapOf(
            "friendId" to friendId
        )

        return getObservable(api.deleteFriend(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * 해당 친구에게 위치 공유 차단
     */
    fun locationBlockFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<SimpleResult> {
        val params = mapOf(
            "friendId" to friendId
        )

        return getObservable(api.locationBlockFriend(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    /**
     * 해당 친구에게 위치 공유 차단 해제
     */
    fun locationUnblockFriend(uiMode: ApiMode.UIMode, friendId: Long): Observable<SimpleResult> {
        val params = mapOf(
            "friendId" to friendId
        )

        return getObservable(api.locationUnblockFriend(Gson().toJsonTree(params)), uiMode)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    fun getAlaramAgree() : Observable<AgreeResult> {
        return getObservable(api.getMemberEventReceiveAgree(), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun setAlarmAgree(json: JsonObject) : Observable<SimpleResult> {
        return getObservable(api.setMemberEventReceiveAgree(json), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getEventInfo() : Observable<EventResult> {
        return getObservable(api.getEventInfo(), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getEventList() : Observable<EventResult> {
        return getObservable(api.getEventInfoList(), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    @Deprecated("Not used")
    fun getGameInfo() : Observable<GameResult> {
        return getObservable(api.getGameInfo(), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun setPushToken(json: JsonObject) : Observable<SimpleResult> {
        return getObservable(api.setPushToken(json), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    /**
     * NFT 컬렉션 정보를 가져옵니다
     */
    fun getNFTCollectionList(loadingType: ApiMode.UIMode, memberId: Long, currentPage: Int, perPage: Int): Observable<NFTCollectionListResult> {
        return getObservable(nftApi.getNFTCollectionList(memberId, currentPage, perPage), loadingType)
            .apply {
                subscribeBy(onNext = { data ->
                    Log.i(TAG, "getNFTCollectionList data: ${data}")
                }, onError = {}, onComplete = {})
            }
    }

    fun getMyNFTCollectionList(loadingType: ApiMode.UIMode, currentPage: Int, perPage: Int): Observable<NFTCollectionListResult> {
        return getNFTCollectionList(loadingType, _member.value!!.memberId, currentPage, perPage)
    }

    fun setNotSeenWeek(day: String) {
        ToryApplication.localStorage.setString(LocalStorageKey.WEEK_NOT_SEEN, day)
    }


    fun getNotSeenWeek() : String {
        return ToryApplication.localStorage.getString(LocalStorageKey.WEEK_NOT_SEEN, "")
    }

    fun setMyPageTutorial(isView : Boolean) {
        return ToryApplication.localStorage.setBoolean(LocalStorageKey.MY_PAGE_TUTORIAL, isView)
    }

    fun getMyPageTutorial() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.MY_PAGE_TUTORIAL, false)
    }

    fun setNFTGuide(keyValue : String, isShow: Boolean) {
        ToryApplication.localStorage.setBoolean(keyValue, isShow)
    }
    fun setNFTGuideHome(isHide : Boolean) {
        ToryApplication.localStorage.setBoolean(LocalStorageKey.GUIDE_HOME, isHide)
    }

    fun getNFTGuideHome() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.GUIDE_HOME, true)
    }

    fun setNFTGuideMint(isShow: Boolean) {
        ToryApplication.localStorage.setBoolean(LocalStorageKey.GUIDE_MINT, isShow)
    }

    fun getNFTGuideMint() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.GUIDE_MINT, true)
    }

    fun setNFTGuideCollection(isShow: Boolean) {
        ToryApplication.localStorage.setBoolean(LocalStorageKey.GUIDE_COLLECTION, isShow)
    }

    fun getNFTGuideCollection() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.GUIDE_COLLECTION, true)
    }

    fun setNFTGuideAuction(isShow: Boolean) {
        ToryApplication.localStorage.setBoolean(LocalStorageKey.GUIDE_AUCTION, isShow)
    }

    fun getNFTGuideAuction() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.GUIDE_AUCTION, true)
    }

    fun setNFTGuildSale(isShow: Boolean) {
        ToryApplication.localStorage.setBoolean(LocalStorageKey.GUIDE_SALE, isShow)
    }

    fun getNFTGuildSale() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.GUIDE_SALE, true)
    }

    fun getPermissionInfo() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.PERMISSION_INFO_KEY, false)
    }

    fun setPermissionInfo(isPermission : Boolean) {
        return ToryApplication.localStorage.setBoolean(LocalStorageKey.PERMISSION_INFO_KEY, isPermission)
    }


    fun getStepTutorial() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.STEP_TUTORIAL, false)
    }

    fun setStepTutorial(isShow: Boolean)  {
        return ToryApplication.localStorage.setBoolean(LocalStorageKey.STEP_TUTORIAL, isShow)
    }

    fun getAdEventDate() : Long {
        return ToryApplication.localStorage.getLong(LocalStorageKey.AD_EVENT_DATE, 0)
    }

    fun setAdEventDate(currentTimeMillis : Long) {
        return ToryApplication.localStorage.setLong(LocalStorageKey.AD_EVENT_DATE, currentTimeMillis)
    }

    fun setIsShowBottomDialog(isShow: Boolean) {
        return ToryApplication.localStorage.setBoolean(LocalStorageKey.IS_SHOW_DIALOG, isShow)
    }

    fun getIsShowBottomDialog() : Boolean {
        return ToryApplication.localStorage.getBoolean(LocalStorageKey.IS_SHOW_DIALOG, true)
    }


    fun getMileageHistory(length : Int, page : Int, period : String) : Observable<HistoryResult> {
        return getObservable(api.getMileageHistory(length, page, period), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getPointCharge(length : Int, page : Int, period : String) : Observable<ChargeHistoryResult> {
        return getObservable(api.getPointCharge(length, page, period), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getPointHistory(length : Int, page : Int, period : String) : Observable<HistoryResult> {
        return getObservable(api.getPointHistory(length, page, period), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getEventWalk() : Observable<WalkEventResult> {
        return getObservable(api.getEventWalk(), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun setEventWalk(json: JsonObject) : Observable<SimpleResult> {
        return getObservable(api.setEventWalk(json), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    fun getChannels(json: JsonObject) : Observable<ChannelsResult> {
        return getObservable(messengerApi.getChannels(json), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getNoticeList() : Observable<List<BBSNoticeDTO>> {
        return getObservable(api.getNotice(), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!.lists
            }
    }

    fun getWholeModelingAvatar() : Observable<List<WholeModelDTO>> {
        return getObservable(api.getAvatarWhole(), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!.wholeModelList
            }
    }

    fun setWholeModelingAvatar(json: JsonObject) : Observable<SimpleResult> {
        return getObservable(api.setAvatarWhole(json), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun setProfileName(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.setProfileName(json), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }

    /**
     * Avatar Category 목록 API
     */
    fun getAvatarCategory(category : String) : Observable<List<AvatarModelingDTO>> {
        return getObservable(api.getAvatarCategory(category), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!.avatarModelingList
            }
    }

    fun getAvatarColor(category: String) : Observable<List<AvatarColorDTO>> {
        return getObservable(api.getAvatarColor(category), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!.avatarColorList
            }
    }

    fun avatarSave(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.avatarSave(json), ApiMode.UIMode.NONE)
            /*
           .filter {
               it.isResultOK
           }
           .map {
               it.result!!
           }
            */
            .map {
                it
            }
    }

    fun isOwned(json: JsonObject) : Observable<SimpleResult> {
        return getObservable(api.isOwned(json), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    fun avatarBuy(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.avatarBuy(json), ApiMode.UIMode.NONE)
            /*
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
             */
            .map {
                it
            }
    }

    ///////////////////////////////////////////////////////////////////////////////////
    fun getLiveSeminar() : Observable<List<SeminarDto>> {
        return getObservable(api.getLiveSeminar(), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!.liveSeminarList
            }
    }

    fun getDateSeminar(searchDate : String) : Observable<List<SeminarDto>> {
        return getObservable(api.getDateSeminar("date", searchDate), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!.liveSeminarList
            }
    }


    fun getSeminarDetail(id : Int) : Observable<SeminarDetailDto> {
        return getObservable(api.getSeminarDetail(id), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result
            }
    }

    fun setParticipate(id: Int) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.setParticipate(id), ApiMode.UIMode.NONE)
            /*
            .filter{
                it.isResultOK
            }
             */
            .map {
                it
            }
    }

    fun getSeminar() : Observable<SeminarContentResult> {
        return getObservable(api.getSeminar(), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getSeminar(lastid : Int) : Observable<SeminarContentResult> {
        return getObservable(api.getSeminar(lastid), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getParticipationSeminar() : Observable<SeminarContentResult> {
        return getObservable(api.getParticipationSeminar(), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getParticipationSeminar(id : Int) : Observable<SeminarContentResult> {
        return getObservable(api.getParticipationSeminar("participation", id), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    fun getCreateSeminar() : Observable<SeminarContentResult> {
        return getObservable(api.getCreateSeminar(), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getCreateSeminar(lastid : Int) : Observable<SeminarContentResult> {
        return getObservable(api.getCreateSeminar("create", lastid), ApiMode.UIMode.NONE)
            .filter{
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    fun getRecommandMeta() : Observable<List<RoomInfoDto>> {
        return getObservable(api.getRecommandMeta(), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.roomList
            }
    }

    fun setSeminarEnter(roomId: Int, json: JsonObject):Observable<ApiResponse<SeminarEnterResult>> {
        return getObservable(api.setSeminarEnter(roomId, json), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }

    fun getRoomInfo(roomSize : String) : Observable<List<RoomInfoDto>> {
        return getObservable(api.getSeminarRoom(roomSize = roomSize), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.roomList
            }
    }

    fun setSeminar(json: JsonObject): Observable<SimpleResult> {
        return getObservable(api.setSeminar(json), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }


    fun deleteMySeminar(id : Int) : Observable<SimpleResult> {
        return getObservable(api.deleteMySeminar(id), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun search(query : String) : Observable<SeminarContentResult> {
        return getObservable(api.search(query), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun search(query : String, lastId: Int) : Observable<SeminarContentResult> {
        return getObservable(api.search(query, lastId), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun updateSeminar(id : Int, json: JsonObject): Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.updateSeminar(id, json), ApiMode.UIMode.NONE)
            /*
            .filter {
                it.isResultOK
            }
             */
            .map {
                it
            }
    }

    fun getVideoUrl() : Observable<VideoResult> {
        return getObservable(api.getVideoUrl(), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getVideoUrl(json: JsonObject): Observable<VideoResult> {
        return getObservable(apiVersion2.getVideoUrl(json = json), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!
            }
    }

    fun getRoomPassword(id : Int) : Observable<ApiResponse<PasswordResult>> {
        return getObservable(api.getRoomPassword(id), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }

    /******************************************************************************************************************/
    fun getChattingList(json: JsonObject) : Observable<List<ChattingRoom>> {
        return getObservable(metaBusApi.getMetaBusChattingRoom(json), ApiMode.UIMode.NONE)
            /*
            .filter {
                it.isResultOK
            }
            .map {
                it.result!!.rooms
            }
             */
            .map {
                it.result!!.rooms
            }
    }


    fun setChattingReport(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.setChattingReport(json), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }


    fun friendChangeStatus(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.friendChangeStatus(json), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }

    fun getFriendsInfo(json: JsonObject) : Observable<ApiResponse<FriendsInfo>> {
        return getObservable(api.getFriendInfo(json), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }


    fun pushChatInvite(json: JsonObject) : Observable<ApiResponse<InviteResult>> {
        return getObservable(api.pushChatInvite(json), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }

    /********************************************************************************************************************************/
    /**
     * 2023.09.21 add Api
     */

    fun ttcLogin(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.ttcLogin(json), ApiMode.UIMode.NONE)
            .map {
                it
            }
    }

    fun getLecture(json : JsonObject) : Observable<LectureResult> {
        return getObservable(api.getLecture(json = json), ApiMode.UIMode.NONE)

            .filter {
                it.isResultOK
            }
            .map {
                Timber.d("getLecture ${it.result}")
                it.result!!
            }
    }

    fun getLectureInfo(json : JsonObject) : Observable<LectureVideoInfoResult> {
        return getObservable(api.getLectureInfo(json = json), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                Timber.d("getLecture ${it.result}")
                it.result!!
            }
    }

    fun getVideoInfo(json: JsonObject) : Observable<ApiResponse<VideoInfoResult>> {
        return getObservable(api.getVideoInfo(json), ApiMode.UIMode.NONE)
            .filter {
                it.isResultOK
            }
            .map {
                it
            }
    }

    fun videoUpdatePlayingPosition(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.videoUpdatePlayingPosition(json = json), ApiMode.UIMode.NONE)
            /*
            .filter {
                it.isResultOK
            }
             */
            .map {
                it
            }
    }

    fun videoUpdateEndPosition(json: JsonObject) : Observable<ApiResponse<SimpleResult>> {
        return getObservable(api.videoUpdateEndPosition(json = json), ApiMode.UIMode.NONE)
            /*
            .filter {
                it.isResultOK
            }
             */
            .map {
                it
            }
    }

}