package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName

data class AgreeResult(
    @SerializedName("agreementList") val agreementList: List<AgreeDTO>
)
