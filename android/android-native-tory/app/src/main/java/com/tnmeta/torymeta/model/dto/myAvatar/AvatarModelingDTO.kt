package com.tnmeta.torymeta.model.dto.myAvatar

data class AvatarModelingDTO(
    val id                      : Int,
    val modelingCode            : String,
    val imgUrl                  : String,
    val group                   : String,
    val basicItem               : Int,
    val pointCd                 : Int,
    val isOwned                 : Int,
    val payCount                : Int,
    val price                   : Int,

    var isSelect                : Boolean = false,
    var isDefaultSelect         : Boolean = false
)
