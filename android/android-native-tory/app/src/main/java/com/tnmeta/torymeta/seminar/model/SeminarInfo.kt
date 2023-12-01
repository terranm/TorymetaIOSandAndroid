package com.tnmeta.torymeta.seminar.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class SeminarInfo(
    val id : Int,
    val roomImageUrl : String
): Parcelable
