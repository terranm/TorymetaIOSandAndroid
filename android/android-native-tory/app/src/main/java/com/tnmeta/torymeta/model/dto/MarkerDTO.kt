package com.tnmeta.torymeta.model.dto

/**
 * MarkerDTO
 */
data class MarkerDTO (
    val imgUrl:     String,
    val lat:        Double,
    val lng:        Double,
    val markerId:   Int,
    val markerType: Int,
    val memberId:   Long?,
    val universityCode: String?
)

