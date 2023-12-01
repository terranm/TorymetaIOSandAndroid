package com.tnmeta.torymeta.model.chatting.report

data class Report(
    val chatRoomId: Int,
    val memberId: Int,
    val reportMainType: Int,
    val reportSubType: List<Int>
)