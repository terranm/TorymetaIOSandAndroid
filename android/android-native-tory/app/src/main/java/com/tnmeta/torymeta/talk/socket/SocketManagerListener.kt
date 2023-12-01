package com.tnmeta.torymeta.talk.socket

import com.google.firebase.crashlytics.internal.model.CrashlyticsReport.Session.User




interface SocketManagerListener {
    /**
     * when socket connected
     */
    fun onConnect()

    /**
     * socket failed while trying to connect
     */
    fun onSocketFailed()

    /**
     * socket connected, connect to room
     */
    fun onLoginWithSocket()

    /**
     * user left from room
     */
//    fun onUserLeft(user: User?)

    /**
//     * received typing
//     */
//    fun onTyping(typing: SendTyping?)
//
//    /**
//     * received message
//     */
//    fun onMessageReceived(message: Message?)
//
//    /**
//     * received messages update
//     */
//    fun onMessagesUpdated(messages: List<Message?>?)

    /**
     * receive new user connect to room
     */
    fun onNewUser(vararg args: Any?)

    /**
     * receive socket error
     */
    fun onSocketError(code: Int)

}