package com.tnmeta.torymeta.model.meta

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Member(
    val emailId: String,
    val memberId: Long,
    val name: String,
    val phoneNum: String,
    val profileName: String,
    val universityCode: String
):Parcelable {
    constructor() : this("", 0, "", "", "", "")
}