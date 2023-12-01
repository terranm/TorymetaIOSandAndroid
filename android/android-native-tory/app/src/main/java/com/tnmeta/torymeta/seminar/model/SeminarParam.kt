package com.tnmeta.torymeta.seminar.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize


@Parcelize
data class SeminarParam(
    val roomId  : Int,
    val title   : String,
    val description : String,

    val teacherDescription : String,

    val startAt     : String,
    val endAt       : String,

    val curriculumImgUrl    : String,
    val seminarUrl          : String,
    val password            : String,
    val secretYn            : String,
    val maxEnterCount       : Int,

    val createRoomCount     : Int

): Parcelable