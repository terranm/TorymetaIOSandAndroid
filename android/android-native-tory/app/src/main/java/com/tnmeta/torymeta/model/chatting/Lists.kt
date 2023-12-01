package com.tnmeta.torymeta.model.chatting

data class Lists(
    val chid: Int,
    val chnm: String,
    val lastmessage: Lastmessage,
    val members: List<Member>,
    val unreadcnt: Int
)