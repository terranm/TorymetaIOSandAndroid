package com.tnmeta.torymeta.seminar.model.seminar

import android.os.Parcel
import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Room(
    val createdAt: String,
    val modifiedAt: String,

    val id: Int,
    val maxParticipation: Int,
    val roomImageUrl: String,
    val roomSize: String,
    val roomType: String,
    val uniCode : String,
    val showYn : String

): Parcelable