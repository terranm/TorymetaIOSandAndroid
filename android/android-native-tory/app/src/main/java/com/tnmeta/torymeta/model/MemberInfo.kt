package com.tnmeta.torymeta.model

data class MemberInfo(
    val memberId : Int,
    val profileName : String,
    val isInvitedYn : String,
    val imgUrl      : String,
    val phoneNum    : String,
    val isMember    : Int
)
