package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.FriendDTO


data class FriendBlockListResult (
    @SerializedName("blockFriendList") val list: List<FriendDTO>
)
