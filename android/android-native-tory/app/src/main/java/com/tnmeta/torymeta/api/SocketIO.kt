package com.tnmeta.torymeta.api

import android.util.Log
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.utils.SBJSON
import io.socket.client.IO
import io.socket.client.Socket
import io.socket.emitter.Emitter
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

private const val TAG = "Socket"
private typealias OnReceivedListener = (Any?) -> Unit

object SocketIO {
    object Api {
        val URL = if( Constants.IS_PRODUCTION_SERVER ) {
            "https://test-msn.torymeta.com"
        } else {
            "https://test-msn.torymeta.com"
        }

        val LOGIN                           = "login"           // memberid는 init api로 가져오는데 login 필요?
        val ENTER_BACKGROUND                = "background"
        val ENTER_FOREGROUND                = "foreground"

        //// iOS
        // forcelogin - login 없이 forcelogin만
        // create - 채팅방 개설, exist 체크
        // invite - 채팅방 친구 초대하기
        // leave - 채팅방 나가기
        // message - 채팅 송/신
        // read - 채팅방
        // read all - http api
            // 채팅방 1개에 대한 읽음 처리
        // read - socket api
            // 메시지 1개에 대한 읽음 처리
    }

    private val repository: ToryRepository
    private val socket: Socket = IO.socket(Api.URL, IO.Options().apply {
        forceNew = true
        reconnectionAttempts = 10
        reconnectionDelay = 6000
//        auth = mapOf(
//            "EIO" to "4"
//        )
        // iOS
//        .log(true),
//        .forceNew(true),
//        .reconnectAttempts(10),
//        .reconnectWait(6000),
//        .connectParams(["EIO":"4"]),
//        .forceWebsockets(true),
//        .compress
    })

    init {
        repository = ToryApplication.getRepository(ToryApplication.activity!!)
        observeOn()
    }

    /**
     * 수신된 기본 메시지를 처리합니다
     */
    private fun observeOn() {
        on(Socket.EVENT_CONNECT) {
            login()
        }

        on(Socket.EVENT_DISCONNECT) {
            // Log.d(TAG, "Socket is diconnect:  ${it}")
        }

        on(Socket.EVENT_CONNECT_ERROR) {
            // Log.d(TAG, "Socket is connect error:  ${it}")
        }

        // 로그인
        on(Api.LOGIN) {
            it?.let { data ->
                val result = SBJSON.parse(data) as Map<String, Any?>
                val code = result["code"] as String? ?: ""
                val message = result["msg"] as String? ?: ""
                val memberId = (result["sub"] as String? ?: "0").toInt()
            }
        }
    }

    /**
     * 메시지 전송
     */
    fun emit(event: String, params: Any? = null, listener: OnReceivedListener? = null) {
        if( params == null ) {
            Log.d(TAG, "--> emit: $event")
            socket.emit(event)
        } else {
            Log.d(TAG, "--> emit: $event, params: $params")
            socket.emit(event, SBJSON.toJSONValue(params))
        }

        once(event, listener)
    }

    /**
     * 메시지 수신
     */
    fun on(event: String, listener: OnReceivedListener? = null) {
        socket.on(event) { args ->
            if( args.isEmpty() ) {
                Log.i(TAG, "<-- on: ${event}")
                if( listener != null )  listener!!(null)
            } else {
                Log.i(TAG, "<-- on: ${event}: ${args[0]}")
                if( listener != null )  listener!!(args[0])
            }
        }
    }

    /**
     * 메시지 수신 (1회만)
     */
    fun once(event: String, listener: OnReceivedListener? = null) {
        socket.once(event) { args ->
            if( args.isEmpty() ) {
                Log.i(TAG, "<-- once: ${event}")
                if( listener != null )  listener!!(null)
            } else {
                Log.i(TAG, "<-- once: ${event}: ${args[0]}")
                if( listener != null )  listener!!(args[0])
            }
        }
    }

    /**
     * 소켓 연결
     */
    fun connect() {
        disconnect()
        socket.connect()
    }

    /**
     * 소켓 연결 해제
     */
    fun disconnect() {
        socket.disconnect()
    }

    fun login() {
        val params = mapOf(
            "authorization" to repository.getLoginToken()
        )

        emit(Api.LOGIN, params)
    }

    fun enterBackground() {
        emit(Api.ENTER_BACKGROUND)
    }

    fun enterForeground() {
        emit(Api.ENTER_FOREGROUND)
    }
}