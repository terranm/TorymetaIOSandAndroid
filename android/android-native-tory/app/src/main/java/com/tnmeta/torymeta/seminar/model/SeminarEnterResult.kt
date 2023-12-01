package com.tnmeta.torymeta.seminar.model

import com.google.gson.annotations.SerializedName

data class SeminarEnterResult(
    @SerializedName("enterYn")          val enterYn : String,
    @SerializedName("unitySeminarId")   val unitySeminarId : String,
    @SerializedName("seminarUrl")       val seminarUrl  : String,
    @SerializedName("roomId")           val roomId  : String,
)
