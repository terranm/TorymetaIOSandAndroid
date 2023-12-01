package com.tnmeta.torymeta.videoplayer.model.param

data class PlayVideoUpdateEndParam(
    val applyId         : Int,
    val lecId           : Int,
    val wrOrder         : Int,
    val lmsTimeId       : Int,
    val isStudied       : Boolean,
    val endCk           : String,
    val time            : Float,
    val contentTime     : Float
)
