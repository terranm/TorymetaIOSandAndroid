package com.tnmeta.torymeta.chattinglounge.model

import com.google.gson.annotations.SerializedName

data class RoomsResult(
    @SerializedName("rooms")            val rooms : List<ChattingRoom>
)
