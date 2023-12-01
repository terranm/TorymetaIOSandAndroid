package com.tnmeta.torymeta.model.meta

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class MetaVerseDto(
    val member: Member,
    val characterId: String,
    val options: Options,
    val scene: String

) : Parcelable