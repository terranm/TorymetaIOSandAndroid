package com.tnmeta.torymeta.videoplayer.model

data class VideoInfoResult(
    val headerTitle : String,
    val contentUrl  : String,
    val applyId     : Int,
    val lecId       : Int,
    var curpos      : Int,
    val wrOrder     : Int,
    val lmsTimeId   : Int,
    val isStudied   : Boolean,
    val endCk       : String,
    val time        : String
)
