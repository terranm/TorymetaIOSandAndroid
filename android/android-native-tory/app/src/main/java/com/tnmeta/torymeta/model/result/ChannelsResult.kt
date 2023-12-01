package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.chatting.ListItem

data class ChannelsResult (

    //@SerializedName("result")               val result : Channels

    @SerializedName("totcnt")               val totcnt  : Int = 0,
    @SerializedName("remain")               val remain  : Int = 0,
    @SerializedName("lists")                val lists   : List<ListItem>
)