package com.tnmeta.torymeta.model.dto.chatting

import com.google.gson.annotations.SerializedName

data class ListItem(
    @SerializedName("chil")                 val chil : Int = 0,
    @SerializedName("chnm")                 val chnm : String = "",
    @SerializedName("unreadcnt")            val unreadcnt : Int = 0,
    @SerializedName("members")              val memberArray : List<MemberItem>,
    @SerializedName("lastmessage")          val lastmessage : LastMessage
)
