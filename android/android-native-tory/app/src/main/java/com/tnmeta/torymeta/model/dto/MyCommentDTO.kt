package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.BoardType


/**
 * MyCommentDTO
 */
data class MyCommentDTO (
    @SerializedName("bbs_id") val id: Int,
    @SerializedName("bbs_type") val originType: Int,
    @SerializedName("comment") val content: String,
    @SerializedName("reg_dt") val date: String) {
    val type: BoardType
        get() = BoardType.intToType(originType)
}
