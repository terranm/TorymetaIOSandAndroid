package com.tnmeta.torymeta.common

object Constants {
    // true - 운영 서버 / false - 개발 서버
    const val IS_PRODUCTION_SERVER           = false
    const val is_FirebaseAnalytics           = true

    const val PROFILE_IMAGE_MAX_WIDTH        = 500
    const val PROFILE_IMAGE_MAX_HEIGHT       = 500

    const val EventBottomDialogFragmentTag   = "EventBottomDialogFragmentTag"
    const val SeminarPasswordBottomDialogFragmentTag = "SeminarPasswordBottomDialogFragmentTag"
    const val BuyItemsBottomDialogFragmentTag = "BuyItemsBottomDialogFragmentTag"

    const val FRAGMENT_REQUEST_CODE         = "fragment:requestCode"

    const val YesValue                      = "Y"
    const val NoValue                       = "N"
    const val ChatLounge                    = "chat_lounge"

    const val BannerType                    = "v2"

}

object EventBottomID {
    const val STU                           = "stu"
    const val TTCAUTH                       = "ttcauth"
}

object InAppBilling {
    const val BASE_64_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjGN47R2kmS+EHNx5+YmjtjgeTNsgvf58M+9gQuTaOoUPCVOyxejXJ3TeaYoM2mMh+Orabflu6bRwsRzxZKs04RA1jyEkOolPHmpIrA3fqYd3sUe509gJ05QH+v2TTTrY2v8GZRNNnSw4AG7xeF5bW13d3Fu6c8cstPvONGkk8C5h6zncUTUGzKTsvZavh3gNHVXZGnjY2iaNuVMbLkHvZh1m4cqiQg4FpDU3RjD8vzMLtfrz9kUMGRWbO7ZwQHfGkB2MQ1AKhfhk5SUBVo45d5IELZcs/H1fb0hqo2QCfBuT6kNwW2EiRoqs0rlPoO8W5cuo8W9twYnEkTrUlgqftQIDAQAB"
}

object LocalStorageKey {
    const val WEB_VIEW_LOGIN_TOKEN                  = "WEB_VIEW_LOGIN_TOKEN"
    const val WEB_VIEW_AUTO_LOGIN                   = "WEB_VIEW_AUTO_LOGIN"
    const val WEB_VIEW_NFT_BC_TOKEN                 = "WEB_VIEW_NFT_BC_TOKEN"

    const val FCM_TOKEN                             = "FCM_TOKEN"

    const val WEEK_NOT_SEEN                         = "_WEEK_NOT_SEEN_"
    const val MY_PAGE_TUTORIAL                      = "_MY_PAGE_TUTORIAL_"

    const val GUIDE_HOME                            = "GUIDE_HOME"
    const val GUIDE_MINT                            = "GUIDE_MINT"
    const val GUIDE_COLLECTION                      = "GUIDE_COLLECTION"
    const val GUIDE_AUCTION                         = "GUIDE_AUCTION"
    const val GUIDE_SALE                            = "GUIDE_SALE"

    const val PERMISSION_INFO_KEY                   = "_PERMISSION_INFO_KEY_"

    const val STEP_TUTORIAL                         = "_STEP_TUTORIAL_"

    const val AD_EVENT_DATE                         = "_AD_EVENT_DATE_"

    const val IS_SHOW_DIALOG                        = "_IS_SHOW_DIALOG_"

}

object Params  {
    const val PUSH_DATA_PARAM                       = "_PUSH_DATA_PARAM_"

    const val SEMINAR_DETAIL_INFO                   = "_SEMINAR_DETAIL_INFO_"

    const val SEMINAR_ID                            = "_SEMINAR__ID_"

    const val LECTUREINFO                           = "_LECTUREINFO_"
}


object RestAPI {
    const val API_SEARCH_COUNT      = 10
}


object FirebaseParam {
    const val type                          = "type"
    const val type_value                    = "aos"
    const val member_id                     = "member_id"

    const val mobile_intro                  = "mobile_intro"
    const val mobile_universitySelect       = "mobile_universitySelect"

    const val mobile_campus                 = "mobile_campus"
    const val mobile_mypage                 = "mobile_mypage"
    const val mobile_nft                    = "mobile_nft"

    const val mobile_present                = "mobile_present"

    const val mobile_metaverse              = "mobile_metaverse"
    const val mobile_seminar                = "mobile_seminar"

    const val mobile_torytolk               = "mobile_torytolk"

    const val mobile_community_market       = "mobile_community_market"
    const val mobile_community_gother       = "mobile_community_gother"
    const val mobile_community_talk         = "mobile_community_talk"
    const val mobile_community_help         = "mobile_community_help"

    const val mobile_school_meal            = "mobile_school_meal"
    const val mobile_school_event           = "mobile_school_event"
    const val mobile_m2e                    = "mobile_m2e"
    const val mobile_torycharge             = "mobile_torycharge"
    const val mobile_setting                = "mobile_setting"
    const val mobile_notice                 = "mobile_notice"
    const val mobile_torycharge_history     = "mobile_torycharge_history"
    const val mobile_torycharge_transaction = "mobile_torycharge_transaction"
    const val mobile_mileage_history        = "mobile_mileage_history"

    ///2023.07.21
    const val mobile_seminacenter           = "mobile_seminacenter"
    const val mobile_torylounge             = "mobile_torylounge"
    const val mobile_seminasearch           = "mobile_seminasearch"
    const val mobile_seminaschedule         = "mobile_seminaschedule"
    const val mobile_mysemina_apply         = "mobile_mysemina_apply"
    const val mobile_mysemina_set           = "mobile_mysemina_set"
    const val mobile_3dcampus               = "mobile_3dcampus"

    ///2023.10.12
    const val mobile_bottom_ttc_classroom   = "mobile_bottom_ttc_classroom"
    const val mobile_ttc_myclassroom        = "mobile_ttc_myclassroom"
}

object ToryMetaCallObject {
    const val NativeManager                 =    "NativeManager"
}

object ToryMetaCallFunction {
    const val SendToUnity                   =    "SendToUnity"
}

object ToryMetaMessageType {
    const val AvatarInfo                    =   "AvatarInfo"
    const val SwitchSceneSimple             =   "SwitchSceneSimple"
    const val AvatarRotate                  =   "AvatarRotate"
    const val CamUp                         =   "CamUp"
    const val CamDown                       =   "CamDown"

    const val CharacterSet                  =   "CharacterSet"
    const val SwitchScene                   =   "SwitchScene"

    const val ChatCreate                    =   "ChatCreate"

    const val DoAction                      =   "DoAction"

    const val ChatJoin                      =   "ChatJoin"

    const val JoinChat                      =   "JoinChat"

    const val LoungeVideoUrl                =   "LoungeVideoUrl"

    const val PassMember                    =   "PassMember"

}



object ToryMetaUnityCallType {
    const val Awake                        =    "Awake"
    const val Start                        =    "Start"
    const val OnDestroy                    =    "OnDestroy"

    const val NativeBack                   =    "NativeBack"
    const val NativeShowChattingModal      =    "NativeShowChattingModal"
    const val FormCall                     =    "FormCall"
    const val InvitableList                =    "InvitableList"

    const val NativeShowModal              =    "NativeShowModal"

    const val RequireLoungeVideoUrl        =    "RequireLoungeVideoUrl"

    const val RequireMember                =    "RequireMember"

}

object FormType {
    const val PasswordInput                 =   "PasswordInput"
    const val ChatCreate                    =   "ChatCreate"
    const val ChatList                      =   "ChatList"
    const val ParticipantsList              =   "ParticipantsList"
    const val ParticipantsMenu              =   "ParticipantsMenu"
    const val Report                        =   "Report"
    const val InvitableList                 =   "InvitableList"
}



object ToryMetaMethodParam {
    const val AvatarSelect_ZoomIn           =       "SelectView_ZoomIn"
    const val AvatarSelect_ZoomOut          =       "SelectView_ZoomOut"
    const val AvatarSelect_Rotation         =       "SelectView_Rotation"
    const val AvatarSelect                  =       "SelectView_Select"
    const val AvatarView                    =       "AvatarView"
    const val SwitchScene                   =       "SwitchScene"

    const val SendInputValue                =       "SendInputValue"
    const val SendRespond                   =       "SendRespond"
    const val QuitWaiting                   =       "QuitWaiting"

}

object ToryMetaSceneParam {
    const val lobby                         =       "lobby"
    const val world                         =       "world"
    const val seminar                       =       "seminar"

    const val AvatarView                    =       "AvatarView"
    const val SelectView                    =       "SelectView"
}

object ChattingAction{
    const val   Kick                        =       "Kick"
    const val   Mandate                     =       "Mandate"
    const val   Silence                     =       "Silence"
    const val   Warning                     =       "Warning"

    const val   ChatJoin                    =       "ChatJoin"
    const val   RequestInvitable            =       "RequestInvitable"
    const val   ChatInvite                  =       "ChatInvite"
    const val   JoinByPush                  =       "JoinByPush"
}


object RoomSize {
    const val SMALL                         =       "SMALL"
    const val MEDIUM                        =       "MEDIUM"
    const val LARGE                         =       "LARGE"
}

object SeminarStatus {
    const val   BEFORE_START                =       "BEFORE_START"
    const val   START                       =       "START"
    const val   END                         =       "END"

    const val   CONFIRM                     =       "CONFIRM"
    const val   REJECT                      =       "REJECT"
}