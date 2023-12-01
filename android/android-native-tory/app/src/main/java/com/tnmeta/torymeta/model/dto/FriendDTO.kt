package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName



typealias OnFriendListener = (FriendDTO) -> Unit

/**
 * FriendDTO
 */
data class FriendDTO (
    val memberId: Long,
    val profileName: String,
    val phoneNum: String?,
    val imgUrl: String,
    var blockYn: String?,
    var locationBlockYn: String?,
    // 친구 요청 전송 여부
    @SerializedName("isInvitedYn") var requestedYN: String?) {

    // 내 위치 공유 여부
    var isLocationBlocked: Boolean
        get() = (locationBlockYn == "Y")
        set(value) {
            locationBlockYn = if( value ) {
                "Y"
            } else {
                "N"
            }
        }

    // 친구 요청 전송 여부
    val isFriendRequested: Boolean
        get() = (requestedYN == "Y")

    fun sendRequest() {
        requestedYN = "Y"
    }
}
