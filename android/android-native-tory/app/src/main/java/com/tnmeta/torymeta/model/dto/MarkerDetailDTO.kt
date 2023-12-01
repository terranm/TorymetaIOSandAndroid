package com.tnmeta.torymeta.model.dto

/**
 * MarkerDetailDTO
 */
data class MarkerDetailDTO (
    val addressName: String,
    val categoryCode: String,
    val imgUrl: String,
    val lat: Double,
    val lng: Double,
    val makerId: Int,
    val phoneNumber: String,
    val placeName: String
)
