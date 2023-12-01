package com.tnmeta.torymeta.model.push

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class PushMessageInfo (
    val title : String,
    val content : String,
    val actionUrl : String

): Parcelable



