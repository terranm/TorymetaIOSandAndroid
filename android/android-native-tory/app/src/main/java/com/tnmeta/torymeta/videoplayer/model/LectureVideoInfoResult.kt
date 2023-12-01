package com.tnmeta.torymeta.videoplayer.model

import com.google.gson.annotations.SerializedName

data class LectureVideoInfoResult(
    @SerializedName("list")          val list: List<LectureVideoInfo>
)
