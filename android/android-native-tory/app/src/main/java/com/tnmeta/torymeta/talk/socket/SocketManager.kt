package com.tnmeta.torymeta.talk.socket

import android.content.Context
import com.google.firebase.crashlytics.internal.model.CrashlyticsReport.Session.User
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.tnmeta.torymeta.api.Api
import io.socket.client.IO
import io.socket.client.Socket
import org.json.JSONObject
import timber.log.Timber
import java.net.URISyntaxException


open class SocketManager {
    private var socketManager: SocketManager? = null

    private var mSocket: Socket? = null
    private var mListener: SocketManagerListener? = null

    fun getInstance(): SocketManager? {
        if (socketManager == null) {
            socketManager = SocketManager()
        }
        return socketManager
    }

    fun setListener(listener: SocketManagerListener?) {
        mListener = listener
    }

    /**
     * connect to socket
     */
    fun connectToSocket(context: Context?) {
        Timber.d("Connecting to socket")
        if (mSocket != null) {
            mSocket!!.close()
            mSocket!!.disconnect()
            mSocket = null
        }
        try {
            val opts: IO.Options = IO.Options()
            opts.forceNew = true
            opts.transports = arrayOf("websocket")
            mSocket = IO.socket(Api.MessengerUrl.BASE, opts)
            mSocket!!.connect()
        } catch (e: URISyntaxException) {
            e.printStackTrace()
            socketFailedDialog()
            return
        }

        /*
        if (mListener != null) mListener!!.onLoginWithSocket()
        mSocket!!.on(Socket.EVENT_CONNECT, object : Listener() {
            fun call(vararg args: Any?) {
                if (mListener != null) mListener!!.onConnect()
            }
        })

        mSocket.on(Socket.EVENT_CONNECT_ERROR, object : Listener() {
            fun call(vararg args: Any?) {
                socketFailedDialog()
            }
        })

        mSocket.on(Socket.EVENT_ERROR, object : Listener() {
            fun call(vararg args: Any?) {
                socketFailedDialog()
            }
        })

        mSocket.on(Socket.EVENT_CONNECT_TIMEOUT, object : Listener() {
            fun call(vararg args: Any?) {
                socketFailedDialog()
            }
        })

        mSocket.on(Const.EmitKeyWord.NEW_USER, object : Listener() {
            fun call(vararg args: Any?) {
                if (mListener != null) mListener!!.onNewUser(*args)
            }
        })

        mSocket.on(Const.EmitKeyWord.USER_LEFT, object : Listener() {
            fun call(vararg args: Any) {
                val userLeft = args[0].toString()
                val gson = Gson()
                try {
                    val user = gson.fromJson(userLeft, User::class.java)
                    if (mListener != null) mListener.onUserLeft(user)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        })

        mSocket.on(Const.EmitKeyWord.SEND_TYPING, object : Listener() {
            fun call(vararg args: Any) {
                val sendTyping = args[0].toString()
                val gson = Gson()
                try {
                    val typing: SendTyping = gson.fromJson(sendTyping, SendTyping::class.java)
                    if (mListener != null) mListener.onTyping(typing)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        })

        mSocket.on(Const.EmitKeyWord.NEW_MESSAGE, object : Listener() {
            fun call(vararg args: Any) {
                LogCS.w("LOG", "MESSAGE RECEIVED")
                val newMessage = args[0].toString()
                val gson = Gson()
                try {
                    val message: Message = gson.fromJson(newMessage, Message::class.java)
                    if (mListener != null) mListener.onMessageReceived(message)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        })
        mSocket.on(Const.EmitKeyWord.MESSAGE_UPDATED, object : Listener() {
            fun call(vararg args: Any) {
                val newMessage = args[0].toString()
                val gson = Gson()
                try {
                    val messages: List<Message> = gson.fromJson<List<Message>>(newMessage, object : TypeToken<List<Message?>?>() {}.type)
                    if (mListener != null) mListener.onMessagesUpdated(messages)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        })
        mSocket.on(Const.EmitKeyWord.SOCKET_ERROR, object : Listener() {
            fun call(vararg args: Any) {
                val response = args[0].toString()
                val gson = Gson()
                try {
                    val responseModel: BaseModel = gson.fromJson(response, BaseModel::class.java)
                    if (mListener != null) mListener!!.onSocketError(responseModel.code)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        })
         */
    }

    protected fun socketFailedDialog() {
        if (mListener != null) mListener!!.onSocketFailed()
    }

    /**
     * emit message to socket
     *
     * @param emitType type of emit message
     * @param jsonObject data for send to server
     */
    fun emitMessage(emitType: String?, jsonObject: JSONObject?) {
        if (mSocket != null) mSocket!!.emit(emitType, jsonObject)
    }

    /**
     * close socket and disconnect to socket and set socket and listener to null
     */
    fun closeAndDisconnectSocket() {
        if (mSocket != null) {
            Timber.d("Closing socket")
            mSocket!!.close()
            mSocket!!.disconnect()
            mSocket = null
            mListener = null
        }
    }

    /**
     * reconnect to socket if socket is null or disconnected
     */
    fun tryToReconnect(context: Context?) {
        Timber.d( "Check for socket reconnect")
        if (mSocket != null) {
            if (mSocket!!.connected()) {
            } else {
                connectToSocket(context)
            }
        } else {
            connectToSocket(context)
        }
    }

    /**
     * check if socket is connected
     */
    fun isSocketConnect(): Boolean {
        return if (mSocket == null) false else mSocket!!.connected()
    }
}