package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.HistoryDTO

data class HistoryResult(
    @SerializedName("historyList") val historyList: List<HistoryDTO>
)
