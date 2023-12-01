package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName

data class UpdateProfileResult (
    @SerializedName("imgUrl") val imgUrl: String,
    @SerializedName("uploadSuccessYn") val uploadSuccessYn: String
)