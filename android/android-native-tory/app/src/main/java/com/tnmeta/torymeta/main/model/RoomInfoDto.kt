package com.tnmeta.torymeta.main.model

data class RoomInfoDto(
    val roomId          : Int,
    val roomType        : String,
    val roomSize        : String,
    val roomName        : String,
    val uniCode         : String,
    val maxParticipation  : Int,
    val roomImageUrl    : String,

    var isSelect               : Boolean = false
)
