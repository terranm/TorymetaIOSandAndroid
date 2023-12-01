package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.MyWriteDTO

data class MyWriteListResult (
    @SerializedName("lists") val list: List<MyWriteDTO>
)
