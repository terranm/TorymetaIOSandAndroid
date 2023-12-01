package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName

data class ChargeHistoryDTO(
    @SerializedName("chargeDay")            val chargeDay   : String,
    @SerializedName("chargeType")           val chargeType  : String,
    @SerializedName("quantity")             val quantity    : Int
)
