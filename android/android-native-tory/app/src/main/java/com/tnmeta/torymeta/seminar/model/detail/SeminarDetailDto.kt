package com.tnmeta.torymeta.seminar.model.detail

data class SeminarDetailDto(
    val title           : String,
    val status          : String,

    val roomImageUrl    : String,
    val description     : String,
    val teacherId       : Long,
    val teacherName     : String,

    val startAt         : String,
    val endAt           : String,
    val secretYn        : String,

    val participationCount  : Int,
    val maxEnterCount    : Int,
    val curriculumImageUrl : String,

    val seminarUrl      : String,
    val roomId          : Int,

    val participateYn   : String

)
