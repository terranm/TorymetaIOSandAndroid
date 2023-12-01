package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.StepConditionDTO

data class WalkEventResult(
    @SerializedName("maxInsideStep")            val maxInsideStep   : Int,
    @SerializedName("maxOutsideStep")           val maxOutsideStep  : Int,
    @SerializedName("stepCondition")            val stepCondition   : List<StepConditionDTO>,
    @SerializedName("insideRatio")              val insideRatio     : Double,
    @SerializedName("outsideRatio")             val outsideRatio     : Double,
    @SerializedName("inStepYnArr")              var inStepYnArr     : ArrayList<String>,
    @SerializedName("outStepYnArr")             var outStepYnArr     : ArrayList<String>
)
