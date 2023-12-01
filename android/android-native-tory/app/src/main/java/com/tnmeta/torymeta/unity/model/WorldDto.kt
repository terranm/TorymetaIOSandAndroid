package com.tnmeta.torymeta.unity.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize


@Parcelize
data class WorldDto(
    val groupCode       : String = "",
    val id              : Int = 0,
    val scene           : String = "",
    val universityCode  : String = ""
): Parcelable
