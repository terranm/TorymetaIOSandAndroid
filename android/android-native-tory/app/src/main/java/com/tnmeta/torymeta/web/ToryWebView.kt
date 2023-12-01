package com.tnmeta.torymeta.web

import android.app.Activity
import android.app.Dialog
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.net.http.SslError
import android.os.Build
import android.os.Message
import android.util.AttributeSet
import android.util.Log
import android.view.KeyEvent
import android.view.ViewGroup
import android.webkit.*
import androidx.appcompat.app.AlertDialog
import androidx.databinding.ktx.BuildConfig
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.utils.SBJSON
import timber.log.Timber
import java.net.URISyntaxException


class ToryWebView: WebView {
    companion object {
        const val TAG          = "WebView"
    }

    lateinit var activity: Activity
    var isFirstPageLoaded = false
    var isErrorPage: Boolean = false
    var doClearHistory: Boolean = false

    // 웹뷰 생성 후 최초 로딩되는 url
    lateinit var firstUrl: String

    /**
     * OnClientEventListener
     */
    interface OnClientEventListener {
        fun onPageStarted(view: WebView, url: String?)
        fun onPageFinished(view: WebView, url: String?)
        fun onFirstPageLoaded(view: WebView)
        fun onProgressChanged(view: WebView, newProgress: Int)
        fun onReceivedError(view: WebView, errorCode: Int, description: String?, failingUrl: String?)
        fun onShowFileChooser(webView: WebView?, filePathCallback: ValueCallback<Array<Uri>>?, fileChooserParams: WebChromeClient.FileChooserParams?): Boolean
    }
    var onClientEventListener: OnClientEventListener? = null

    /**
     * OnBridgeEventListener
     */
    interface OnBridgeEventListener {
        fun onEvent(view: ToryWebView, event: Web.BridgeEvent, data: HashMap<String, Any?>)
    }
    var onBridgeEventListener: OnBridgeEventListener? = null

    constructor(context: Context): super(context) {
    }

    constructor(context: Context, attrs: AttributeSet): super(context, attrs) {
    }

    constructor(context: Context, attrs: AttributeSet, defStyle: Int): super(context, attrs, defStyle) {
    }

    init {
        initSettings()
        initClient()
        initChromeClient()
        addJavascriptInterface(JsBridge(this), Web.BRIDGE)
    }

    private class JsBridge(private val webView: ToryWebView) {
        @JavascriptInterface
        fun tory(json: String) {
            if( json.isEmpty() || webView.onBridgeEventListener == null ) {
                return
            }

            Timber.d("JsBridge - $json")

            val data = SBJSON.parse(json) as HashMap<String, Any?>

            //Timber.d("JsBridge - " + data["key"])

            val functionName = data["functionName"] as String? ?: data["key"] as String

            Timber.d("JsBridge - $functionName")

            val event = Web.BridgeEvent.stringToEvent(functionName)

            webView.onBridgeEventListener!!.onEvent(webView, event, data)
        }
    }

    fun loadFirstUrl(url: String) {
        firstUrl = url
        loadUrl(url)
    }

    fun safeRemove() {
        onClientEventListener = null
        onBridgeEventListener = null
        removeJavascriptInterface(Web.BRIDGE)

        stopLoading()
        (parent as ViewGroup).removeView(this)
        destroy()
    }

    /**
     * JavaScript 함수를 호출합니다
     */
    fun evaluateJavascript(functionName: String, param: String,
                           callback: ValueCallback<String>? = null) {
        val script = "javascript: $functionName('$param');"
        evaluateJavascript(script, ValueCallback { result ->
            callback?.onReceiveValue(result)
        })
    }

    private fun handleUrl(url: String?): Boolean {
        Log.i(TAG, "handleUrl: $url")

        if( url.isNullOrEmpty() ) {
            return false
        }

        val uri = Uri.parse(url)

        // START - NICE아이디
        if( url.startsWith("intent://") ) {
            var intent: Intent? = null
            try {
                intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
                if( intent != null ) {
                    //앱실행
                    activity.startActivity(intent)
                }
            } catch(e: URISyntaxException) {
                // URI 문법 오류 시 처리 구간
            } catch(e: ActivityNotFoundException) {
                val packageName = intent!!.getPackage()
                if( packageName != "" ) {
                    // 앱이 설치되어 있지 않을 경우 구글마켓 이동
                    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$packageName")))
                }
            }

            return true
        }
        else if( url.startsWith("https://play.google.com/store/apps/details?id=") || url.startsWith("market://details?id=") ) {
            //표준창 내 앱설치하기 버튼 클릭 시 PlayStore 앱으로 연결하기 위한 로직
            var uri = Uri.parse(url);
            var packageName = uri.getQueryParameter("id");

            if( !packageName.isNullOrEmpty() ) {
                // 구글마켓 이동
                activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$packageName")));
            }

            return true;
        }
        // END - NICE아이디

        // handle the scheme
        // market
        if( url.startsWith("market://") ) {
            try {
                var intent = Intent(Intent.ACTION_VIEW, uri)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                activity.startActivity(intent)
                return true
            } catch(e: Exception) {
                e.printStackTrace()
            }
        }
        // tel
        else if( url.startsWith("tel:") ) {
            var intent = Intent(Intent.ACTION_DIAL, uri)
            activity.startActivity(intent)
            return true
        }
        // mailto
        else if( url.startsWith("mailto:") ) {
            var intent = Intent(Intent.ACTION_SENDTO, uri)
            activity.startActivity(intent)
            return true
        }

        // pdf
        /*
        val ext = url.substring(url.lastIndexOf("."), url.length)

        if( ext == ".pdf" ) {
            try {
                var intent = Intent(Intent.ACTION_VIEW)
                intent.setDataAndType(uri, "application/pdf")
                activity.startActivity(intent)
            } catch(e: Exception) {
                e.printStackTrace()
            }

            return true
        }
        */

        Log.i(TAG, "handleUrl =====> not handled")
        return false
    }

    /**
     * 웹뷰 설정 초기화
     */
    private fun initSettings() {

        settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            cacheMode = WebSettings.LOAD_NO_CACHE

            // Enable zooming in web view
            setSupportZoom(true)
            builtInZoomControls = true
            displayZoomControls = false
            textZoom = 100

            // Enable disable images in web view
            blockNetworkImage = false
            // Whether the WebView should load image resources
            loadsImagesAutomatically = true

            //
            //setAppCacheEnabled(true)
            cacheMode = WebSettings.LOAD_NO_CACHE
            setPluginState(WebSettings.PluginState.ON);
            //

            // More web view settings
            if( Build.VERSION.SDK_INT >= Build.VERSION_CODES.O ) {
                // settings.safeBrowsingEnabled = true  // api 26
            }

            useWideViewPort = true
            loadWithOverviewMode = true
            javaScriptCanOpenWindowsAutomatically = true

            // More optional settings, you can enable it by yourself
            setSupportMultipleWindows(true)
            allowContentAccess = true
            allowFileAccess = true
            setGeolocationEnabled(true)

        }


        // WebView settings
        setNetworkAvailable(true)

        // enable debugging
        //setWebContentsDebuggingEnabled(BuildConfig.DEBUG);

        /*
            if SDK version is greater of 19 then activate hardware acceleration
            otherwise activate software acceleration
        */
        // setLayerType(View.LAYER_TYPE_HARDWARE, null)

        // 쿠키
        if( Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP ) {
            settings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW

            var cookieManager = CookieManager.getInstance()
            cookieManager.setAcceptCookie(true)
            cookieManager.setAcceptThirdPartyCookies(this, true)
        }
    }

    /**
     * 웹뷰 클라이언트 초기화
     */
    private fun initClient() {

        val webView = this

        webViewClient = object: WebViewClient() {
            override fun onLoadResource(view: WebView?, url: String?) {
                super.onLoadResource(view, url)
                Log.i(TAG, "onLoadResource url: ${url}")

                // 페이지 로딩 시 스크립트 추가
                val script = Web.getUserScript(firstUrl)
                if( script.isNotEmpty() ) {
                    view?.evaluateJavascript(script, null)
                }
            }

            override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
                return handleUrl(url)
            }

            override fun onReceivedError(view: WebView?, errorCode: Int, description: String?, failingUrl: String?) {
                super.onReceivedError(view, errorCode, description, failingUrl)
                Log.e(TAG, "onReceivedError: $description code: $errorCode")

                isErrorPage = true

                when( errorCode ) {
                    ERROR_HOST_LOOKUP-> {
                        //Log.e(TAG, "DISCONNECTED")
                        Timber.tag(TAG).d("DISCONNECTED")
                    }

                    ERROR_TIMEOUT-> {
                        //Log.e(TAG, "TIMEOUT")
                        Timber.tag(TAG).d("TIMEOUT")
                    }
                    else -> {
                    }
                }

                onClientEventListener?.onReceivedError(webView, errorCode, description, failingUrl)
                // send(WebApi.NETWORK_ERROR)
            }

            override fun onReceivedHttpError(view: WebView?, request: WebResourceRequest?, errorResponse: WebResourceResponse?) {
                super.onReceivedHttpError(view, request, errorResponse)
                // isErrorPage = true
            }

            override fun onReceivedSslError(view: WebView?, handler: SslErrorHandler?, error: SslError?) {
                super.onReceivedSslError(view, handler, error)
                //Log.e(TAG, "onReceivedSslError: ${error?.toString()}")
                Timber.tag(TAG).d("onReceivedSslError: ${error?.toString()}")

                // 강제 실행
                handler?.proceed()
            }

            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                Timber.tag(TAG).i("onPageStarted url=${url!!}")
                super.onPageStarted(view, url, favicon)

                isErrorPage = false
                onClientEventListener?.onPageStarted(webView, url)

                Timber.tag(TAG).i("onPageStarted end")
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)

                Timber.tag(TAG).i("onPageFinished url=${url!!}")

                if( doClearHistory ) {
                    clearHistory()
                    doClearHistory = false
                }

                onClientEventListener?.onPageFinished(webView, url)

                if( !isFirstPageLoaded && !isErrorPage ) {
                    isFirstPageLoaded = true
                    onClientEventListener?.onFirstPageLoaded(webView)
                }

                Timber.tag(TAG).i("onPageFinished end")
            }
        }
    }

    /**
     * 웹뷰 크롬클라이언트 초기화
     */
    private var popup: Dialog? = null

    private fun initChromeClient() {
        val webView = this

        webChromeClient = object: WebChromeClient() {

            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                super.onProgressChanged(view, newProgress)
                onClientEventListener?.onProgressChanged(webView, newProgress)
            }

            override fun onJsAlert(view: WebView?, url: String?, message: String?, result: JsResult?): Boolean {
                AlertDialog.Builder(context)
                    .setCancelable(false)
                    .setMessage(message)
                    .setPositiveButton(R.string.system_alert_btn_ok) { p0, p1 ->
                        result?.confirm()
                    }
                    .show()

                return true
            }
            override fun onJsConfirm(view: WebView?, url: String?, message: String?, result: JsResult?): Boolean {
                AlertDialog.Builder(context)
                    .setCancelable(false)
                    .setMessage(message)
                    .setPositiveButton(R.string.system_alert_btn_ok) { p0, p1 ->
                        result?.confirm()
                    }
                    .setNegativeButton(R.string.system_alert_btn_cancel) { p0, p1 ->
                        result?.cancel()
                    }
                    .show()

                return true
            }

            override fun onShowFileChooser(webView: WebView?, filePathCallback: ValueCallback<Array<Uri>>?, fileChooserParams: FileChooserParams?): Boolean {
                onClientEventListener?.let {
                    return it.onShowFileChooser(webView, filePathCallback, fileChooserParams)
                }
                return false
            }

            override fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissions.Callback?) {
                super.onGeolocationPermissionsShowPrompt(origin, callback)
                Timber.tag(TAG).i("onGeolocationPermissionsShowPrompt: $origin")
            }

            override fun onGeolocationPermissionsHidePrompt() {
                super.onGeolocationPermissionsHidePrompt()
                Timber.tag(TAG).i("onGeolocationPermissionsHidePrompt")
            }

            /**
             * 창 열림
             */
            override fun onCreateWindow(view: WebView?, isDialog: Boolean, isUserGesture: Boolean, resultMsg: Message?): Boolean {
                var popupWebView = WebView(activity)
                popupWebView.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
                popupWebView.settings.apply {
                    javaScriptEnabled = true
                    domStorageEnabled = true
                    javaScriptCanOpenWindowsAutomatically = true
                    loadWithOverviewMode = true
                    useWideViewPort = true

                    cacheMode = WebSettings.LOAD_NO_CACHE
                    loadsImagesAutomatically = true
                    setSupportZoom(true)
                    builtInZoomControls = true
                    displayZoomControls = false
                    textZoom = 100
                }

                popupWebView.webViewClient = object: WebViewClient() {
                    override fun onLoadResource(view: WebView?, url: String?) {
                        // webView.webViewClient.onLoadResource(view, url)
                    }
                    override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
                        return handleUrl(url)
                    }
                }
                popupWebView.webChromeClient = object: WebChromeClient() {
                    override fun onJsAlert(view: WebView?, url: String?, message: String?, result: JsResult?): Boolean {
                        return webView.webChromeClient!!.onJsAlert(view, url, message, result)
                    }
                    override fun onJsConfirm(view: WebView?, url: String?, message: String?, result: JsResult?): Boolean {
                        return webView.webChromeClient!!.onJsConfirm(view, url, message, result)
                    }

                    override fun onCloseWindow(window: WebView?) {
                        window?.destroy()
                        popup?.dismiss()
                        super.onCloseWindow(window)
                    }
                }

                popup = Dialog(activity, R.style.AppTheme_Tory_White).apply {
                    setContentView(popupWebView)
                    setOnKeyListener(DialogInterface.OnKeyListener { dialog, keyCode, event ->
                        if( keyCode == KeyEvent.KEYCODE_BACK ) {
                            if( popupWebView.canGoBack() ) {
                                popupWebView.goBack()
                            } else {
                                dialog.dismiss()
                            }
                            true
                        } else {
                            false
                        }
                    })
                    setOnDismissListener {
                        popupWebView.destroy()
                        popup = null
                    }
                }
                popup!!.show()

                (resultMsg?.obj as WebView.WebViewTransport).webView = popupWebView
                resultMsg?.sendToTarget()

                return true
            }

            /**
             * 창 닫힘
             */
            override fun onCloseWindow(window: WebView?) {
                window?.destroy()
                super.onCloseWindow(window)
            }
        }
    }
}