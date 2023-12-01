package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName

data class LocationInfoDTO(
    @SerializedName("isInRange")        val isInRange : String
)
