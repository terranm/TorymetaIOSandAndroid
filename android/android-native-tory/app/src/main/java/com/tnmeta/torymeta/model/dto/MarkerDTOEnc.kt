package com.tnmeta.torymeta.model.dto

data class MarkerDTOEnc(
    val memberId:   Long?,
    val lat:        String,
    val lng:        String,
    val imgUrl:     String,
    val markerId:   Int,
    val markerType: Int,
    val universityCode: String?
)
