package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName

data class SimpleResult (
    @SerializedName("processYn") val processYn: String?) {
    val isSucceed: Boolean
        get() = (processYn == "Y")
}
