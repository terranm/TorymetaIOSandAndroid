package com.tnmeta.torymeta.videoplayer.model

data class LectureVideoInfo(
    var process         : Int,
    var period          : Int,
    var title           : String,
    var dayLimit        : Boolean,
    var applyId         : Int,
    var lecId           : Int,
    var wrOrder         : Int,

    var isSelect        : Boolean = false
)
