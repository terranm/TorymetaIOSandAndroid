package com.tnmeta.torymeta.seminar.model.seminar

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Content(
    val id: Int,
    val status: String,
    val room: Room,

    val title: String,
    val description: String,
    val teacherId: Long,
    val teacherName : String,
    val teacherImageUrl : String,
    val teacherDescription: String,

    val startAt: String,
    val endAt: String,

    val curriculumImgUrl: String,
    val password : String,
    val secretYn: String,

    val maxEnterCount : Int,
    val participationYn : String,
    val currentParticipation: Int,
    val requestParticipation: Int,

    //val seminarFiles : String,

    val showYn: String,


): Parcelable