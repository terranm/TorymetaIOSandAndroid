package com.tnmeta.torymeta.model.meta

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Options(
    var videoVisibility: String,
    var audioMute: String,
    var textVisibility: String,
    var openParticipation: String,
    var roomOwner: String,
    var url: String,
    var roomId: String,
    var roomType: String,
    var title : String,
    var videoStartTime : String,
    var isAppRelease : Boolean,

) : Parcelable {
    constructor() : this("", "Y", "N", "Y", "Y", "", "", "", "", "", true)
}