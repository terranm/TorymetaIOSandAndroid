package com.tnmeta.torymeta.main.model

import com.google.gson.annotations.SerializedName

data class RoomListResult (
    @SerializedName("roomList") val roomList: List<RoomInfoDto>
)