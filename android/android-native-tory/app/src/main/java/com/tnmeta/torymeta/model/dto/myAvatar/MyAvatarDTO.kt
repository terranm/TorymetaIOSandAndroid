package com.tnmeta.torymeta.model.dto.myAvatar

import android.os.Parcel
import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class MyAvatarDTO(
   var avatarType : String?,
   var groupCode : String?,
   var groupName : String?,
   var id       : Int?,
   var name     : String?

): Parcelable
