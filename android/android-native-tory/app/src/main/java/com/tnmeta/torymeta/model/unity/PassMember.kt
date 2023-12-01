package com.tnmeta.torymeta.model.unity

data class PassMember(
    val memberId    : Int,
    val imgUrl      : String,
    val birth       : String,
    val emailId     : String,
    val name        : String,
    val phoneNum    : String,
    val profileName : String,
    val status      : String,
    val universityCode  : String,
    val locationExposeYn : Int,
    val certUniYn       : Int
)
