package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName

data class GameDTO(
    @SerializedName("gameType")             val gameType: String,
    @SerializedName("gameName")             val gameName: String,
    @SerializedName("gameUrl")              val gameUrl: String,
    @SerializedName("gameImgUrl")           val gameImgUrl: String

)
