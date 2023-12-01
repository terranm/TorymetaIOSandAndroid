package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.FriendDTO


data class FriendRequestListResult (
    @SerializedName("newFriendList") val list: List<FriendDTO>
)
