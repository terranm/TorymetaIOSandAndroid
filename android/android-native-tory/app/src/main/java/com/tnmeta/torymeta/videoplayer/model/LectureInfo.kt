package com.tnmeta.torymeta.videoplayer.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class LectureInfo(
    val num     : Int,
    val start   : String,
    val end     : String,
    val cat     : String,
    val subject : String,
    val totalProcess    : Int,
    val link    : String,
    val wrId    : Int,
    val lecId   : Int,
    val clLecSub : String

): Parcelable
