package com.tnmeta.torymeta.model

data class FriendsInfo(
    val newFriendList           : List<MemberInfo>,
    val currentFriendList       : List<MemberInfo>,
    val acceptWaitFriendList    : List<MemberInfo>,
    val friendListInRange       : List<MemberInfo>,
    val friendListOutRange      : List<MemberInfo>
)
