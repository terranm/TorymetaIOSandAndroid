package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.chatting.Lists
import com.tnmeta.torymeta.model.dto.chatting.ListItem

data class Channels(
    @SerializedName("totcnt")               val totcnt  : Int = 0,
    @SerializedName("remain")               val remain  : Int = 0,
    @SerializedName("lists")                val lists   : List<ListItem>
)

