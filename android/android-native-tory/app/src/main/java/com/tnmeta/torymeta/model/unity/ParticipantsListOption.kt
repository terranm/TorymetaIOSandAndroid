package com.tnmeta.torymeta.model.unity


data class ParticipantsListOption(
    val roomId      : String,
    val maxClient   : Int,
    val tableId     : String,
    val chatRoomId  : Int,
    val list        : ArrayList<MemberInfo>
)
