package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName

data class HistoryDTO(
    @SerializedName("useTime")              val useTime     : String,
    @SerializedName("history")              val history     : String,
    @SerializedName("type")                 val type        : Int,
    @SerializedName("quantity")             val quantity    : Int,
    @SerializedName("expireTime")           val expireTime  : String,
    @SerializedName("txId")                 val txId        : String
)
