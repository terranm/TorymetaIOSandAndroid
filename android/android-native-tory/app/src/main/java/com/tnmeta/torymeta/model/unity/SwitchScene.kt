package com.tnmeta.torymeta.model.unity

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class SwitchScene (
    val url         : String,
    val roomType    : String,
    val roomId      : String,
    val roomTitle   : String,
    val videoStartTime  : String,
    val isAppRelease    : Boolean,
    val scene        : String,
    val tableId     : String

): Parcelable {
    constructor() : this(url="", roomType="", roomId="", roomTitle="",
                        videoStartTime="", isAppRelease = false, scene = "", tableId = "")
}
