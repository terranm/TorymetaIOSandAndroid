package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.InfoDTO
import com.tnmeta.torymeta.model.dto.NFTCollectionDTO


data class NFTCollectionListResult (
    @SerializedName("code")         val code: Float,
    @SerializedName("message")      val message: String,
    @SerializedName("data")         val data: List<NFTCollectionDTO>,
    @SerializedName("info")         val info : InfoDTO
)
