package com.tnmeta.torymeta.model.dto.myAvatar

data class AvatarColorDTO(
    val id          : Int,
    val colorCode   : String,
    val group       : String,

    var isSelect    : Boolean = false
)
