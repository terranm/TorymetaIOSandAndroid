package com.tnmeta.torymeta.model.unity

data class MemberInfo(
    val memberId    : String,
    val profileName : String,
    val phoneNum    : String,
    val imgUrl      : String,
    val roomMaker   : Boolean,

    var isEmpty     : Boolean
) {
    constructor() : this(memberId="", profileName="", phoneNum="", imgUrl="", roomMaker =false, isEmpty = false)
}

