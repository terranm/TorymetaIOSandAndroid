package com.tnmeta.torymeta.model.dto


/**
 * MemberDTO
 */
data class MemberDTO (
    val birth: String       = "",
    val certUniYn : Int     = 0,
    val createdTime: String = "",
    val emailId: String     = "",
    var imgUrl: String      = "",
    val memberId: Long      = 0,
    val modifiedTime: String    = "",
    val name: String        = "",
    val password: String    = "",
    val phoneNum: String    = "",
    var profileName: String = "",
    val status: String      = "",
    var universityCode: String  = "",
    var locationExposeYn: Int) {

    // 내 위치 공유 여부
    var isLocationShared: Boolean
        get() = (locationExposeYn == 1)
        set(value) {
            locationExposeYn = if( value ) {
                1
            } else {
                0
            }
        }
}

