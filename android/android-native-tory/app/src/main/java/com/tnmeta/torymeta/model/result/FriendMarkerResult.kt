package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.MarkerDTOEnc

data class FriendMarkerResult (
    //@SerializedName("friendMarkerList") val markerList: MarkerList
    @SerializedName("friendMarkerList")     val markerList : List<MarkerDTOEnc>
)