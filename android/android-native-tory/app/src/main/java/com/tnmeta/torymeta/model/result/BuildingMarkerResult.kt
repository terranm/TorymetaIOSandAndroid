package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.MarkerDTO

typealias MarkerList = List<MarkerDTO>

data class BuildingMarkerResult (
    @SerializedName("markerList") val markerList: MarkerList
)
