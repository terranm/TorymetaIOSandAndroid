package com.tnmeta.torymeta.model.dto.chatting

import com.google.gson.annotations.SerializedName

data class MemberItem(
    @SerializedName("sub")              val sub : Double   = 0.0,
    @SerializedName("nm")               val nm  : String = "",
    @SerializedName("profile")          val profile : String = ""
)
