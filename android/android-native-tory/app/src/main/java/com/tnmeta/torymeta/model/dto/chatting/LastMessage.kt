package com.tnmeta.torymeta.model.dto.chatting

import com.google.gson.annotations.SerializedName

data class LastMessage(
    @SerializedName("msg")              val msg         : String = "",
    @SerializedName("senddate")         val senddate    : String = "",
    @SerializedName("year")             val year        : String = "",
    @SerializedName("month")            val month       : String = "",
    @SerializedName("day")              val day         : String = "",
    @SerializedName("hour")             val hour         : String = "",
    @SerializedName("min")              val min         : String = ""
)
