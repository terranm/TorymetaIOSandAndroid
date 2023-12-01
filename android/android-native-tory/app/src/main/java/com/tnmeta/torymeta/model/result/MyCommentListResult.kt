package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.MyCommentDTO


data class MyCommentListResult (
    @SerializedName("lists") val list: List<MyCommentDTO>
)

