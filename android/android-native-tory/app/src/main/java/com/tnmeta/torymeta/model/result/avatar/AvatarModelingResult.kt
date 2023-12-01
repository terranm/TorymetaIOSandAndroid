package com.tnmeta.torymeta.model.result.avatar

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarModelingDTO

data class AvatarModelingResult(
    @SerializedName("avatarModelingList")          val avatarModelingList: List<AvatarModelingDTO>
)


