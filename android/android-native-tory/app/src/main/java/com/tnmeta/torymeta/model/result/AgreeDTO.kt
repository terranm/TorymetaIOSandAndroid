package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName

data class AgreeDTO(
    @SerializedName("memberId")             val memberId: Int,
    @SerializedName("agreementCd")          val agreementCd: Int,
    @SerializedName("agreementStatus")      val agreementStatus: Int,
    @SerializedName("agreementTime")        val agreementTime: String,
    @SerializedName("modifiedTime")         val modifiedTime: String

)
