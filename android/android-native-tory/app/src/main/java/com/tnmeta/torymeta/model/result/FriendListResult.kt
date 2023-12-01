package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.FriendDTO


data class FriendListResult (
    @SerializedName("friendListInRange") val inRangeList: List<FriendDTO>,
    @SerializedName("friendListOutRange") val outRangeList: List<FriendDTO>
)
