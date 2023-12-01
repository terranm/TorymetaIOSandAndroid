package com.tnmeta.torymeta.model.dto.myAvatar

data class AvataModel(
    var id : Int,
    var modelingCode : String,
    var modelingName : String,
    var imgUrl       : String,
    var colorCode 	 : String,
    var group	     : String,
    var price        : Int,
    var pointCd      : Int,
    var isOwned      : Int,
    var isWear       : Boolean,

    var isSelect     : Boolean
){
    constructor() : this( -1, "", "", "", "", "", 0, 0,  0,false, false)
}
