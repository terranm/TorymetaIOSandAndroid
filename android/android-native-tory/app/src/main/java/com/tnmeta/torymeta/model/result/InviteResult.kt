package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName

data class InviteResult (
    @SerializedName("inviteYn") val inviteYn: String?) {
    val isSucceed: Boolean
        get() = (inviteYn == "Y")
}
