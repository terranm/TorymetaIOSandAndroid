package com.tnmeta.torymeta.main.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class SeminarDto(
    val id                      : Int,
    val title                   : String,
    val currentParticipation    : Int,
    val requestParticipation    : Int,
    val maxParticipation        : Int,
    var startAt                 : String,
    var endAt                   : String,
    val description             : String,
    val roomImageUrl            : String,
    val teacherId               : Long,
    val teacherImageUrl         : String,
    val teacherName             : String,

    val secretYn                : String,
    val status                  : String,
    var participationYn         : String

): Parcelable
