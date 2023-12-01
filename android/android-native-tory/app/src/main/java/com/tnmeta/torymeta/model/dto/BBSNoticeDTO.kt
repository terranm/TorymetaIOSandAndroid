package com.tnmeta.torymeta.model.dto

data class BBSNoticeDTO (
    val bbs_type : Int,
    val bbs_id   : Int,
    val notice_yn : String,
    val bbs_title : String,
    val bbs_content : String,
    val bbs_viewcount : String,
    val reg_id   : Int,
    val name : String,
    val img_url : String,
    val reg_dt : String
)
