package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.UpdateType


data class VersionCheckResult (
    @SerializedName("appStatus") val appStatus: Int) {
    val updateType: UpdateType
        get() = UpdateType.intToType(appStatus)
}