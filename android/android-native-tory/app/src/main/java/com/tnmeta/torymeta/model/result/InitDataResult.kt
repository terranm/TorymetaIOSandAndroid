package com.tnmeta.torymeta.model.result

import com.google.gson.annotations.SerializedName
import com.tnmeta.torymeta.model.dto.EventBanner
import com.tnmeta.torymeta.model.dto.MemberDTO
import com.tnmeta.torymeta.model.dto.ToryItemDTO
import com.tnmeta.torymeta.model.dto.UniversityDTO
import com.tnmeta.torymeta.model.dto.myAvatar.MyAvatarAttr
import com.tnmeta.torymeta.model.dto.myAvatar.MyAvatarDTO


data class InitDataResult (
    @SerializedName("memberVO")             val member:             MemberDTO,

    @SerializedName("tory")                 val point:              Int,

    @SerializedName("mileage")              val mileage:            Int,

    @SerializedName("universityVOList")     val universityList:     List<UniversityDTO>,

    @SerializedName("toryItemList")         val toryItemList:       List<ToryItemDTO>,

    @SerializedName("baseImgUrlArr")        val defaultProfileList: List<String>,

    @SerializedName("showBannerYn")         val showBannerYn   :    String,

    @SerializedName("showOnAirYn")          val showOnAirYn    :    String,

    @SerializedName("eventBannerUrl")       val eventBannerUrl :    String,

    @SerializedName("eventBannerList")      val eventBannerList :   ArrayList<EventBanner>,

    @SerializedName("hasAvatarAttrYn")      val hasAvatarAttrYn :   String,

    @SerializedName("myAvatarAttr")         val myAvatarAttr    :   MyAvatarAttr,

    @SerializedName("ttcStatus")            val ttcStatus       :   String

)
{
    val isShowSeminarPopup: Boolean
        get() = (showBannerYn == "Y")
    val isShowSeminarOnAirButton: Boolean
        get() = (showOnAirYn == "Y")
}
