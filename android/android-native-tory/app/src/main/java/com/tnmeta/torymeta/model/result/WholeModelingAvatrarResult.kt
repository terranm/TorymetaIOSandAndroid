package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.myAvatar.WholeModelDTO

data class WholeModelingAvatrarResult(
    @SerializedName("wholeModelingAvatarList")      val wholeModelList: List<WholeModelDTO>
)
