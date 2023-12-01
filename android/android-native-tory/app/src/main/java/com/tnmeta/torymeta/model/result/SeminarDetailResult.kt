package com.tnmeta.torymeta.model.result

import com.tnmeta.torymeta.model.SeminarStatus


data class SeminarDetailResult (
    val entranceStatus: Int,
    val videoUrl: String?) {
    val status: SeminarStatus
        get() = SeminarStatus.intToType(entranceStatus)
}
