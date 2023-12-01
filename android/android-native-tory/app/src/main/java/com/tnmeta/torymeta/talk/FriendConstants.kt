package com.tnmeta.torymeta.talk

import android.content.Context
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.model.dto.FriendDTO

object FriendConstants {
    fun getTitle(context: Context, type: FriendListType): String {
        return when( type ) {
            FriendListType.NEW->              context.getString(R.string.friend_list_title_new)
            FriendListType.REQUEST->          context.getString(R.string.friend_list_title_request)
            FriendListType.CAMPUS->           context.getString(R.string.friend_list_title_campus)
            FriendListType.UNKNOWN_LOCATION-> context.getString(R.string.friend_list_title_unknown_location)
            FriendListType.BLOCK->            context.getString(R.string.friend_list_title_block)
            else-> "invalid"
        }
    }
}

/**
 * 친구 목록 타입
 */
enum class FriendListType(val i: Int) {
    INVALID(0),
    NEW(1),                 // 새로운 친구 (알 수도 있는 사람)
    REQUEST(2),             // 친구 요청 받은 목록
    CAMPUS(3),              // 캠퍼스에 있는 친구들
    UNKNOWN_LOCATION(4),    // 위치를 알 수 없는 친구들
    BLOCK(5);               // 차단

    companion object {
        fun toType(i: Int): FriendListType {
            return FriendListType.values()
                .find { it.i == i } ?: INVALID
        }

        fun toType(cellType: FriendListCellType): FriendListType {
            return when( cellType ) {
                FriendListCellType.FRIEND_NEW->                 NEW
                FriendListCellType.FRIEND_REQUEST->             REQUEST
                FriendListCellType.FRIEND_CAMPUS->              CAMPUS
                FriendListCellType.FRIEND_UNKNOWN_LOCATION->    UNKNOWN_LOCATION
                FriendListCellType.FRIEND_BLOCK->               BLOCK
                else-> INVALID
            }
        }
    }
}

typealias FriendListMap = HashMap<FriendListType, MutableList<FriendDTO>>

/**
 * 친구 목록 Cell 타입 (View 타입)
 */
enum class FriendListCellType(val i: Int) {
    INVALID(0),
    SEARCH(1),                     // 검색
    LIST_TITLE(2),                 // 리스트 타이틀
    FRIEND_NEW(3),                 // 새로운 친구
    FRIEND_REQUEST(4),             // 친구 요청 받은 목록
    FRIEND_CAMPUS(5),              // 캠퍼스에 있는 친구들
    FRIEND_UNKNOWN_LOCATION(6),    // 위치를 알 수 없는 친구들
    FRIEND_BLOCK(7);               // 차단 친구

    fun isFriendType(): Boolean {
        return this == FRIEND_NEW || this == FRIEND_REQUEST || this == FRIEND_CAMPUS || this == FRIEND_UNKNOWN_LOCATION || this == FRIEND_BLOCK
    }

    companion object {
        fun toType(i: Int): FriendListCellType {
            return FriendListCellType.values()
                .find { it.i == i } ?: FriendListCellType.INVALID
        }

        fun toType(listType: FriendListType): FriendListCellType {
            return when( listType ) {
                FriendListType.NEW->              FRIEND_NEW
                FriendListType.REQUEST->          FRIEND_REQUEST
                FriendListType.CAMPUS->           FRIEND_CAMPUS
                FriendListType.UNKNOWN_LOCATION-> FRIEND_UNKNOWN_LOCATION
                FriendListType.BLOCK->            FRIEND_BLOCK
                else-> INVALID
            }
        }
    }
}