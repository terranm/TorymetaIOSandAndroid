package com.tnmeta.torymeta.model.dto.myAvatar

import android.os.Parcel
import android.os.Parcelable
import kotlinx.android.parcel.Parceler
import kotlinx.android.parcel.Parcelize


@Parcelize
data class MyAvatarAttr(
    var skinCode            : String,
    var skinColorCode       : String,

    var hairCode            : String,
    var hairColorCode       : String,

    var faceCode            : String,
    var faceColorCode       : String,

    var topCode             : String,
    var topColorCode        : String,

    var bottomCode          : String,
    var bottomColorCode     : String,

    var shoesCode           : String,
    var shoesColorCode      : String,

    var bodyCode            : String,

    var hatCode             : String,
    var hatColorCode        : String

): Parcelable
