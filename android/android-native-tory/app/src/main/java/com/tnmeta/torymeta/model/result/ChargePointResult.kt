package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName

data class ChargePointResult (
    @SerializedName("processYn") val processYn: String,
    @SerializedName("tory") val point: Int = 0,
    @SerializedName("mileage") val mileage: Int = 0
)
