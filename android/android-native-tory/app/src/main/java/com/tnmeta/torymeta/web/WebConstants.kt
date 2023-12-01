package com.tnmeta.torymeta.web

import com.tnmeta.torymeta.BuildConfig
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.*
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.intro.SplashActivity
import com.tnmeta.torymeta.model.BoardType
import com.tnmeta.torymeta.model.dto.MyCommentDTO
import com.tnmeta.torymeta.model.dto.MyWriteDTO
import com.tnmeta.torymeta.model.dto.NFTCollectionDTO
import com.tnmeta.torymeta.model.dto.UniversityDTO
import timber.log.Timber
import java.util.Locale

object Web {
    object Url {
        val BASE = if( Constants.IS_PRODUCTION_SERVER ) {
            "https://web.torymeta.com"
        } else {
            "https://test-web.torymeta.com"
        }

        val LOGIN                             = "${BASE}/login/"
        val SCHOOL_EVENT                      = "${BASE}/board/event/"
        val SCHOOL_MEAL                       = "${BASE}/board/food/"
        val SETTING                           = "${BASE}/setting/"
        val NOTICE                            = "${BASE}/notice/"

        val BOARD                             = "${BASE}/board"
        val COMMUNITY                         = "${BOARD}/community"
        val COMMUNITY_TALK                    = "${COMMUNITY}/1/"
        val COMMUNITY_GATHER                  = "${COMMUNITY}/2/"
        val COMMUNITY_HELP                    = "${COMMUNITY}/3/"
        val COMMUNITY_MARKET                  = "${COMMUNITY}/4/"

        val UNIVERSITY_AUTH                   = "${BASE}/university/auth"

        val INFORMATION                       = "${BASE}/setting/gongji"

        //val CHECT_EVENT                       = "${BASE}/event/check/"

        fun getWirteDetailUrl(data: MyWriteDTO): String {
            return "${BOARD}/${BoardType.typeToString(data.type)}/detail/${data.id}?isDirectDetailOpen=true"
        }

        fun getCommentDetailUrl(data: MyCommentDTO): String {
            return "${BOARD}/${BoardType.typeToString(data.type)}/detail/${data.id}?isDirectDetailOpen=true"
        }

        val NFT_BASE = if( Constants.IS_PRODUCTION_SERVER ) {
            "https://webview.bevarrico.com"
        } else {
            "https://test-webview.bevarrico.com"
        }
        val NFT_DETAIL                        = "${NFT_BASE}/extern/nft/detail/"

        fun getNFTUrl(token: String, bcToken: String): String {
            return "${NFT_BASE}?token=${token}" +
                    "&bcToken=${bcToken}"
        }

        fun getNFTUrl(token: String, bcToken: String, repository: ToryRepository ) : String {

            val guideHome = repository.getNFTGuideHome()
            val guideMint = repository.getNFTGuideMint()
            val guideCollection = repository.getNFTGuideCollection()
            val guideAuction = repository.getNFTGuideAuction()
            val guideSale = repository.getNFTGuildSale()

            return "${NFT_BASE}?token=${token}" +
                    "&bcToken=${bcToken}"       +
                    "&guide_home=${guideHome}"  +
                    "&guide_mint=${guideMint}"  +
                    "&guide_collection=${guideCollection}" +
                    "&guide_auction=${guideAuction}"       +
                    "&guide_sale=${guideSale}"
        }


        fun getNFTDetailUrl(token: String, bcToken: String, data: NFTCollectionDTO): String {
            var url = "${NFT_DETAIL}${data.nftIdx}"
            url += "?token=${token}&bcToken=${bcToken}"
            return url
        }

        fun getUniversityAuth(info : UniversityDTO, isModify : Boolean) : String {
            return "${UNIVERSITY_AUTH}?" +
                    "universityCode=${info.universityCode}" +
                    "&domain=${info.emailDomain} " +
                    "&isModify=${isModify}"
        }
    }

    fun getUserScript(firstUrl: String): String {
        val activity = ToryApplication.activity!!
        val repository = ToryApplication.getRepository(activity)
        val version = BuildConfig.VERSION_NAME
        val languageCode = Locale.getDefault().language

        var script = ""

        // 토리메타 Web
        if( firstUrl.startsWith(Url.BASE) ) {
            script += "window.version='${version}';"
            script += "window.token='${repository.getLoginToken()}';"
            script += "window.fcmToken='${repository.getFCMToken()}';"
            script += "window.os='ANDROID';"
            script += "window.isProductRelease=${Constants.IS_PRODUCTION_SERVER};"
            script += "window.serverUrl='${Api.Url.BASE}';"
            script += "window.languageCode='${languageCode}';"

            Timber.tag("WebView").d("script $script")

            // 웹뷰에 로딩된 첫 url로 스크립트를 분기
            script += if( firstUrl.startsWith(Url.BOARD) && firstUrl.contains("/detail/") ) {
                "window.isDirectDetailOpen=true;"
            } else {
                "window.isDirectDetailOpen=false;"
            }
        }
        // NFT Web
        else if( firstUrl.startsWith(Url.NFT_BASE) ) {
            script += "window.appVersion='${version}';"
            script += "window.os='ANDROID';"
            script += "true;"
            script += "window.languageCode='${languageCode}';"

            //Timber.tag("WebView").d("script $script")
        }

        return script
    }

    // Bridge
    const val BRIDGE                                = "AndroidBridge"

    enum class BridgeEvent(val functionName: String) {
        INVALID(""),
        BACK("back"),
        LOGIN_COMPLETED("clickLogin"),
        UPDATE_MEMBER("changeMember"),
        SIGN_OUT("clickSignOut"),
        WITHDRAWAL("clickWithdrawal"),
        SETTING_NOTICE("noticeSetting"),
        CHNAGE_UNIVERSITY("changeUniversity"),
        COMFIRE_CERTUNITYN("comfire_certUniYn"),
        NATIVE_SHOW_BOARD_MODAL("NATIVE_SHOW_BOARD_MODAL"),

        GO_FESTIVAL("goFestival"),

        // NFT
        NFT_SAVE_BC_TOKEN("NATIVE_SAVE_BC_TOKEN"),
        NFT_BALANCE_REFRESH("NATIVE_BALANCE_REFRESH"),
        NFT_GUIDE_PAGE("NATIVE_VISIBLE_SET_GUIDE_PAGE"),
        NFT_NATIVE_CLOSE("NATIVE_CLOSE");

        companion object {
            fun stringToEvent(str: String): BridgeEvent {
                return values().find { it.functionName == str } ?: INVALID
            }
        }
    }
}