package com.tnmeta.torymeta.main.model

import com.google.gson.annotations.SerializedName


data class LiveSeminarResult(
    @SerializedName("liveSeminarList") val liveSeminarList: List<SeminarDto>
)
