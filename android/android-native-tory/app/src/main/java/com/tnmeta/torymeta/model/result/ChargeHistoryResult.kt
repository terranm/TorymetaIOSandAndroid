package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.ChargeHistoryDTO


data class ChargeHistoryResult(
    @SerializedName("chargeHistoryList")        val chargeHistoryList: List<ChargeHistoryDTO>
)
