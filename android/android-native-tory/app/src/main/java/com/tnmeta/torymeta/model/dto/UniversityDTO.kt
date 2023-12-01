package com.tnmeta.torymeta.model.dto

/**
 * UniversityDTO
 */
data class UniversityDTO (
    val universityCode: String,
    val universityName: String,
    val lat: Double,
    val lng: Double,
    val imgUrl: String,
    val emailDomain   : String,
    val radius        : Double,
    val logoImgUrl    : String,
    val logoName      : String
)

