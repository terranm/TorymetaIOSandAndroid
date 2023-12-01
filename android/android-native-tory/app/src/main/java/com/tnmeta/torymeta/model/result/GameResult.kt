package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.GameDTO

data class GameResult(
    @SerializedName("gameList") val gameList: List<GameDTO>
)
