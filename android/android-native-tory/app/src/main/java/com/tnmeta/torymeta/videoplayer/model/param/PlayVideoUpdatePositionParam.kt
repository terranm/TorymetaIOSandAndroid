package com.tnmeta.torymeta.videoplayer.model.param

data class PlayVideoUpdatePositionParam(
    val applyId     : Int,
    val lecId       : Int,
    val wrOrder     : Int,
    val lmsTimeId   : Int,
    val isStudied   : Boolean,
    val contentTime : Float,
    val curpos      : Float
)
