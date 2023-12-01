package com.tnmeta.torymeta.main.model

data class ChattingLoungeDto(
    val roomID : String,
    val title : String,
    val creator : String,
    val chatting_count : Int,
    val chatting_max_count : Int,
    val password : Boolean
)
