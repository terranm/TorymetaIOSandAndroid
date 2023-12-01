package com.tnmeta.torymeta.model.result.avatar

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarColorDTO

data class AvatarColorResult(
    @SerializedName("avatarColorList")          val avatarColorList: List<AvatarColorDTO>
)
