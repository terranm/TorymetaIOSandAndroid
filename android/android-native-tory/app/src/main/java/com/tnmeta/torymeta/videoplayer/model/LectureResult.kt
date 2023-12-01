package com.tnmeta.torymeta.videoplayer.model

import com.google.gson.annotations.SerializedName

data class LectureResult(
    @SerializedName("lectureList")          val lectureList: List<LectureInfo>
)
