package com.tnmeta.torymeta.chattinglounge.model

data class ChattingRoom(
    val     clients         : Int,
    val     locked          : Boolean,
    val     privateRoom     : Boolean,
    val     maxClients      : Int,
    val     unlisted        : Boolean,
    val     createdAt       : String,
    val     creatorName     : String,
    val     roomId          : String,
    val     title           : String,
    val     description     : String,
    val     image           : String,
    val     chatGroup       : String,
    val     tableId         : String,
    val     password        : String
)
