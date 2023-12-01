package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.EventDTO
import com.tnmeta.torymeta.model.dto.EventListDTO

data class EventResult(
    //@SerializedName("eventList") val eventList: List<EventDTO>
    @SerializedName("eventList") val eventList: List<EventListDTO>
)
