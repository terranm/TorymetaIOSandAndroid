package com.tnmeta.torymeta.model

data class FriendChangeStatus(
    val target          : String,
    val status          : String,
    val friendId        : Long
)
