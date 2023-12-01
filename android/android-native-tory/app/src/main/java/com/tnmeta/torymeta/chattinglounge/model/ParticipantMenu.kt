package com.tnmeta.torymeta.chattinglounge.model

enum class MenuType() { Kick, Mandate, Silence, FriendRequest, Report, Warning; }

data class ParticipantMenu(
    val type: MenuType,
    val iconResId: Int,
    val titleResId: Int,
    val txtColor : Int,
)
