package com.tnmeta.torymeta.seminar.model.seminar

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class SeminarFiles(
    val createdAt: String,
    val fileName: String,
    val fileType: String,
    val id: Int,
    val modifiedAt: String,
    val seminarId: Int

): Parcelable