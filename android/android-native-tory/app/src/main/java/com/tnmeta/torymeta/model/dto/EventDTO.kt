package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName

data class EventDTO(
    @SerializedName("eventId")              val eventId: String,
    @SerializedName("eventName")            val eventName: String,
    @SerializedName("type")                 val type : Int,
    @SerializedName("showYn")               val showYn : Int,
    @SerializedName("startTime")            val startTime: String,
    @SerializedName("entTime")              val entTime: String,
    @SerializedName("cardImgUrl")           val cardImgUrl: String,
    @SerializedName("detailPath")           val detailPath: String,
)


data class EventListDTO(
    @SerializedName("eventBannerMgntId")        val eventBannerMgntId   : Int,
    @SerializedName("eventId")                  val eventId             : String,
    @SerializedName("bannerAppUrl")             val bannerAppUrl        : String,
    @SerializedName("bannerLocation")           val bannerLocation      : String,
    @SerializedName("bannerType")               val bannerType          : String,
    @SerializedName("bannerImageUrl")           val bannerImageUrl      : String,
    @SerializedName("externUrl")                val externUrl           : String,
    @SerializedName("title")                    val title               : String,
    @SerializedName("sortOrder")                val sortOrder           : Int,
    @SerializedName("startTime")                val startTime           : String,
    @SerializedName("endTime")                  val endTime             : String
)
