package com.tnmeta.torymeta.model.dto

import com.google.gson.annotations.SerializedName

data class InfoDTO(
    @SerializedName("total")            val total : Int = 0,
    @SerializedName("lastPage")         val lastPage : Int = 0,
    @SerializedName("perPage")          val perPage : Int = 0,
    @SerializedName("currentPage")      val currentPage : Int = 0,
    @SerializedName("from")             val from : Int = 0,
    @SerializedName("to")               val to   : Int = 0

)
