package com.tnmeta.torymeta.api

import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.tnmeta.torymeta.chattinglounge.model.RoomsResult
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.main.model.LiveSeminarResult
import com.tnmeta.torymeta.main.model.RoomListResult
import com.tnmeta.torymeta.model.FriendsInfo
import com.tnmeta.torymeta.model.VideoResult
import com.tnmeta.torymeta.model.dto.FriendDTO
import com.tnmeta.torymeta.model.dto.MarkerDetailDTO
import com.tnmeta.torymeta.model.dto.MemberDTO
import com.tnmeta.torymeta.model.dto.PointDTO
import com.tnmeta.torymeta.model.result.*
import com.tnmeta.torymeta.model.result.avatar.AvatarColorResult
import com.tnmeta.torymeta.model.result.avatar.AvatarModelingResult
import com.tnmeta.torymeta.seminar.model.SeminarEnterResult
import com.tnmeta.torymeta.seminar.model.seminar.SeminarContentResult
import com.tnmeta.torymeta.seminar.model.detail.SeminarDetailDto
import com.tnmeta.torymeta.videoplayer.model.LectureResult
import com.tnmeta.torymeta.videoplayer.model.LectureVideoInfoResult
import com.tnmeta.torymeta.videoplayer.model.VideoInfoResult
import io.reactivex.rxjava3.core.Observable
import okhttp3.MultipartBody
import retrofit2.http.*

/**
 * 서버 API를 정의한 인터페이스입니다 (only HTTP)
 */
interface Api { // ToryApi
    companion object {
        const val TAG = "Api"
        const val PROFILE_UPLOAD_CONTENT_DISPOSITION_NAME = "imgFile"
    }

    object Url {
        val BASE = if( Constants.IS_PRODUCTION_SERVER ) {
            "https://api.torymeta.com"
        } else {
            "https://test-api.torymeta.com"
        }

        const val MEMBER                    = "/member/v1"
        const val MEMBER_V2                 = "/member/v2"
        const val MAP                       = "/map/v1"
        const val BOARD                     = "/bbs/v1"
        const val NOTICES_API               = "/bbs/deauth/v1"

        const val UPDATE_PROFIlE_IMAGE      = "${MEMBER}/member/img/upload"
    }

    object ImageUrl {
        val BASE = if( Constants.IS_PRODUCTION_SERVER ) {
            "https://torymeta-image.s3.ap-northeast-2.amazonaws.com"
        } else {
            "https://test-torymeta-image.s3.ap-northeast-2.amazonaws.com"
        }

        const val AVATAR_WHOLE_MODELING                    = "avatar/whole-modeling"
    }

    object NFTUrl {
        val BASE = if( Constants.IS_PRODUCTION_SERVER ) {
            "https://nft-api.bevarrico.com"
        } else {
            "https://test-nft-api.bevarrico.com"
        }
    }

    object MetaBusUrl {
        val BASE = if( Constants.IS_PRODUCTION_SERVER ) {
            "https://metaverse.torymeta.com"
        } else {
            "https://test-metaverse.torymeta.com"
        }
    }

    @GET("/member/deauth/v1/version/check")
    fun checkVersion(@Query("o") os: String = "AOS",
                     @Query("v") version: String): Observable<ApiResponse<VersionCheckResult>>

    @POST("${Url.MEMBER}/init")
    fun initData(): Observable<ApiResponse<InitDataResult>>

    @POST("${Url.MEMBER}/init")
    fun initData(@Body json: JsonElement): Observable<ApiResponse<InitDataResult>>

    @POST("${Url.MEMBER}/member/get")
    fun getMember(): Observable<ApiResponse<MemberDTO>>

    @GET("${Url.MEMBER}/point")
    fun getPoint(): Observable<ApiResponse<PointDTO>>

    @GET("${Url.MEMBER}/seminar")
    fun getSeminarDetail(): Observable<ApiResponse<SeminarDetailResult>>

    @Multipart
    @POST("${Url.UPDATE_PROFIlE_IMAGE}")
    fun updateProfileImage(@Part files: List<MultipartBody.Part>): Observable<ApiResponse<UpdateProfileResult>>

    @POST("${Url.MEMBER}/member/university/{universityCode}")
    fun updateCampus(@Path("universityCode") universityCode: String): Observable<ApiResponse<UpdateCampusResult>>

    @POST("${Url.MEMBER}/point/charge/aos")
    fun chargePoint(@Body json: JsonElement): Observable<ApiResponse<ChargePointResult>>

    @POST("${Url.MEMBER}/member/location-expose")
    fun updateMyLocationShared(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MAP}/location/update")
    fun updateMyLocation(@Body json: JsonElement): Observable<ApiResponse<Any>>

    @POST("${Url.MAP}/location/update-enc")
    fun updateMyLocationEnc(@Body json: JsonElement): Observable<ApiResponse<Any>>


    @GET("${Url.MAP}/university/{universityCode}/markers")
    fun getCampusBuildingMarker(@Path("universityCode") universityCode: String): Observable<ApiResponse<BuildingMarkerResult>>

    @GET("${Url.MAP}/marker/friend")
    fun getFriendMarkerList(): Observable<ApiResponse<FriendMarkerResult>>

    @GET("${Url.MAP}/marker/friend-enc")
    fun getFriendMarkerListEnc(): Observable<ApiResponse<FriendMarkerResult>>


    @GET("${Url.MAP}/marker/{markerId}")
    fun getMarkerDetail(@Path("markerId") markerId: Int): Observable<ApiResponse<MarkerDetailDTO>>

    @POST("${Url.BOARD}/mythread")
    fun getMyWriteList(): Observable<ApiResponse<MyWriteListResult>>

    @POST("${Url.BOARD}/mycmnt")
    fun getMyCommentList(): Observable<ApiResponse<MyCommentListResult>>

    @GET("${Url.MEMBER}/member/{memberId}")
    fun getFriend(@Path("memberId") memberId: Long): Observable<ApiResponse<FriendDTO>>

    @POST("${Url.MEMBER}/test/new-friends")
    fun getFriendMayKnowList(@Body json: JsonElement): Observable<ApiResponse<FriendMayKnowListResult>>

    @GET("${Url.MEMBER}/test/friend/wait-list")
    fun getFriendRequestList(): Observable<ApiResponse<FriendRequestListResult>>

    @GET("${Url.MEMBER}/test/friend/list")
    fun getFriendList(): Observable<ApiResponse<FriendListResult>>

    @GET("${Url.MEMBER}/test/friend/block-list")
    fun getFriendBlockList(): Observable<ApiResponse<FriendBlockListResult>>

    @POST("${Url.MEMBER}/test/friend/request")
    fun requestFriend(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/friend/accept")
    fun acceptFriend(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/friend/block")
    fun blockFriend(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/friend/unblock")
    fun unblockFriend(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/friend/delete")
    fun deleteFriend(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/friend/location/block")
    fun locationBlockFriend(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/friend/location/unblock")
    fun locationUnblockFriend(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/change-status")
    fun friendChangeStatus(@Body json: JsonElement): Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/test/friends-info")
    fun getFriendInfo(@Body json: JsonElement): Observable<ApiResponse<FriendsInfo>>


    @POST("${Url.MEMBER}/friend/chat-invite")
    fun pushChatInvite(@Body json: JsonElement): Observable<ApiResponse<InviteResult>>


    //// NFT
    @GET("/v1/db/MATIC/nfts")
    fun getNFTCollectionList(@Query("ownerId") ownerId: Long,
                             @Query("currentPage") currentPage: Int,
                             @Query("perPage") perPage: Int,
                             @Query("sort") sort: String = "-updatedAt"): Observable<NFTCollectionListResult>


    @GET("${Url.MEMBER}/member/agreement")
    fun getMemberEventReceiveAgree() : Observable<ApiResponse<AgreeResult>>

    @POST("${Url.MEMBER}/member/agreement")
    fun setMemberEventReceiveAgree(@Body json: JsonObject) : Observable<ApiResponse<SimpleResult>>


    @GET("${Url.MEMBER}/event")
    fun getEventInfo() : Observable<ApiResponse<EventResult>>

    @GET("${Url.MEMBER}/event/list")
    fun getEventInfoList() : Observable<ApiResponse<EventResult>>

    
    @GET("${Url.MEMBER}/mileage/history")
    fun getMileageHistory(@Query("length") length : Int,
                        @Query("page") page : Int,
                        @Query("period") period : String) : Observable<ApiResponse<HistoryResult>>
    @GET("${Url.MEMBER}/point/history")
    fun getPointHistory(@Query("length") length : Int,
                          @Query("page") page : Int,
                          @Query("period") period : String) : Observable<ApiResponse<HistoryResult>>
    @GET("${Url.MEMBER}/point/charge")
    fun getPointCharge(@Query("length") length : Int,
                        @Query("page") page : Int,
                        @Query("period") period : String) : Observable<ApiResponse<ChargeHistoryResult>>

    @Deprecated("Not used")
    @GET("${Url.MEMBER}/game")
    fun getGameInfo() : Observable<ApiResponse<GameResult>>

    @GET("${Url.MEMBER}/event/walk")
    fun getEventWalk() : Observable<ApiResponse<WalkEventResult>>

    @POST("${Url.MEMBER}/event/walk")
    fun setEventWalk(@Body json: JsonObject) : Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/member/push-token")
    fun setPushToken(@Body json: JsonObject) : Observable<ApiResponse<SimpleResult>>


    @GET("${Url.NOTICES_API}/bbs_notice/1/list")
    fun getNotice() : Observable<ApiResponse<NoticeResult>>


    @GET("${Url.MEMBER}/avatar/whole-modeling")
    fun getAvatarWhole() : Observable<ApiResponse<WholeModelingAvatrarResult>>

    @POST("${Url.MEMBER}/avatar")
    fun setAvatarWhole(@Body json: JsonObject) : Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/member/profile-name/change")
    fun setProfileName(@Body json : JsonObject) : Observable<ApiResponse<SimpleResult>>

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    object MessengerUrl {
        val BASE = if( Constants.IS_PRODUCTION_SERVER ) {
            //"http://msn.torymeta.com:3300"
            "https://msn.torymeta.com"
        } else {
            //"http://test-msn.torymeta.com:3300"
            "https://test-msn.torymeta.com"
        }
        const val Messenger_Version                    = "/v1"
    }

    @POST("${MessengerUrl.Messenger_Version}/channels")
    fun getChannels(@Body json: JsonElement) : Observable<ApiResponse<ChannelsResult>>

    @POST("${MessengerUrl.Messenger_Version}/getchannel")
    fun getChannel(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>

    @POST("${MessengerUrl.Messenger_Version}/readall")
    fun realAll(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>

    @POST("${MessengerUrl.Messenger_Version}/{chid}members")
    fun members( @Path(value = "chid") chid : Int)

    @POST("${MessengerUrl.Messenger_Version}/{chid}messages")
    fun messages( @Path(value = "chid") chid : Int, @Body json: JsonElement)

    @POST("${MessengerUrl.Messenger_Version}/{chid}prev_messages")
    fun prevmessages( @Path(value = "chid") chid : Int, @Body json: JsonElement)

    @POST("${MessengerUrl.Messenger_Version}/{chid}next_messages")
    fun nextmessages( @Path(value = "chid") chid : Int, @Body json: JsonElement)


    /**************************************************************************/
    /**
     * Member_v2 세미나 관련 API
     */
    @GET("${Url.MEMBER_V2}/seminar/live")
    fun getLiveSeminar(@Query("query") query: String = "now" ) : Observable<ApiResponse<LiveSeminarResult>>

    @GET("${Url.MEMBER_V2}/seminar/live")
    fun getDateSeminar( @Query("query") query: String = "date",
                        @Query("date") date : String) : Observable<ApiResponse<LiveSeminarResult>>

    @GET("${Url.MEMBER_V2}/seminar")
    fun getSeminar() : Observable<ApiResponse<SeminarContentResult>>

    @GET("${Url.MEMBER_V2}/seminar")
    fun getSeminar(@Query("lastId") lastId : Int) : Observable<ApiResponse<SeminarContentResult>>


    @GET("${Url.MEMBER_V2}/seminar/{id}")
    fun getSeminarDetail(@Path(value = "id") id : Int) : Observable<ApiResponse<SeminarDetailDto>>


    @POST("${Url.MEMBER_V2}/seminar/{id}/participation")
    fun setParticipate(@Path(value = "id") id : Int) : Observable<ApiResponse<SimpleResult>>

    @GET("${Url.MEMBER_V2}/seminar")
    fun getParticipationSeminar(@Query("query") query: String = "participation") : Observable<ApiResponse<SeminarContentResult>>

    @GET("${Url.MEMBER_V2}/seminar")
    fun getParticipationSeminar(@Query("query") query: String = "participation",
                                @Query("lastId") lastId : Int) : Observable<ApiResponse<SeminarContentResult>>


    @GET("${Url.MEMBER_V2}/seminar")
    fun getCreateSeminar(@Query("query") query: String = "create") : Observable<ApiResponse<SeminarContentResult>>

    @GET("${Url.MEMBER_V2}/seminar")
    fun getCreateSeminar(@Query("query") query: String = "create",
                         @Query("lastId") lastId : Int) : Observable<ApiResponse<SeminarContentResult>>


    @GET("${Url.MEMBER_V2}/seminar/room")
    fun getRecommandMeta(@Query("roomType") query: String = "UNI") : Observable<ApiResponse<RoomListResult>>

    @POST("${Url.MEMBER_V2}/seminar/{roomId}/enter")
    fun setSeminarEnter(@Path(value = "roomId") id : Int, @Body json: JsonObject) : Observable<ApiResponse<SeminarEnterResult>>

    @GET("${Url.MEMBER_V2}/seminar/room")
    fun getSeminarRoom(@Query("roomType") query: String = "SEMINAR",
                       @Query("roomSize") roomSize : String) : Observable<ApiResponse<RoomListResult>>

    @POST("${Url.MEMBER_V2}/seminar")
    fun setSeminar(@Body json: JsonObject) : Observable<ApiResponse<SimpleResult>>

    @DELETE("${Url.MEMBER_V2}/seminar/{id}")
    fun deleteMySeminar(@Path(value = "id") id : Int) : Observable<ApiResponse<SimpleResult>>


    @GET("${Url.MEMBER_V2}/seminar/search")
    fun search(@Query("query") query: String) : Observable<ApiResponse<SeminarContentResult>>

    @GET("${Url.MEMBER_V2}/seminar/search")
    fun search(@Query("query") query: String,
                @Query("lastId") lastId : Int) : Observable<ApiResponse<SeminarContentResult>>

    @PATCH("${Url.MEMBER_V2}/seminar/{id}")
    fun updateSeminar(@Path(value = "id") id : Int, @Body json: JsonObject) : Observable<ApiResponse<SimpleResult>>

    @GET("${Url.MEMBER_V2}/video-url")
    fun getVideoUrl() : Observable<ApiResponse<VideoResult>>

    @POST("${Url.MEMBER_V2}/video-url")
    fun getVideoUrl(@Body json: JsonObject) : Observable<ApiResponse<VideoResult>>



    @GET("${Url.MEMBER_V2}/seminar/{roomId}/password")
    fun getRoomPassword(@Path(value = "roomId") id : Int) : Observable<ApiResponse<PasswordResult>>


    /**************************************************************************/
    /** avatar category **/
    @GET("${Url.MEMBER}/avatar/item")
    fun getAvatarCategory(@Query("category") category: String) : Observable<ApiResponse<AvatarModelingResult>>


    @GET("${Url.MEMBER}/avatar/color")
    fun getAvatarColor(@Query("category") category: String) : Observable<ApiResponse<AvatarColorResult>>


    @POST("${Url.MEMBER}/avatar/save")
    fun avatarSave(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/avatar/item/is-owned")
    fun isOwned(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/avatar/buy")
    fun avatarBuy(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>


    /**************************************************************************/
    @POST("metabus-v4/room/list")
    fun getMetaBusChattingRoom(@Body json: JsonElement) : Observable<ApiResponse<RoomsResult>>

    @POST("${Url.MEMBER}/report")
    fun setChattingReport(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>



    /*****************************************************************************/
    @POST("${Url.MEMBER}/ttc-login")
    fun ttcLogin(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/api")
    fun getLecture(@Body json: JsonElement) : Observable<ApiResponse<LectureResult>>

    @POST("${Url.MEMBER}/api-sub")
    fun getLectureInfo(@Body json: JsonElement) : Observable<ApiResponse<LectureVideoInfoResult>>

    @POST("${Url.MEMBER}/api-player")
    fun getVideoInfo(@Body json: JsonElement) : Observable<ApiResponse<VideoInfoResult>>

    @POST("${Url.MEMBER}/api-update-position")
    fun videoUpdatePlayingPosition(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>

    @POST("${Url.MEMBER}/api-update-end")
    fun videoUpdateEndPosition(@Body json: JsonElement) : Observable<ApiResponse<SimpleResult>>

}

