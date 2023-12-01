package com.tnmeta.torymeta.web

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.icu.text.TimeZoneNames
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebView
import androidx.activity.OnBackPressedCallback
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.google.gson.Gson
import com.tnmeta.torymeta.BuildConfig
import com.tnmeta.torymeta.MainBaseActivity
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.api.ApiMode
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.campus.viewmodel.CampusViewModel
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.FirebaseParam
import com.tnmeta.torymeta.databinding.FragmentWebBinding
import com.tnmeta.torymeta.dialog.CommonDialogInterface
import com.tnmeta.torymeta.dialog.TogetherDialogFragment
import com.tnmeta.torymeta.model.event.EventType
import com.tnmeta.torymeta.model.event.EventTypeBus
import com.tnmeta.torymeta.intro.SplashActivity
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.NFTWebBridgeData
import com.tnmeta.torymeta.model.param.InitVersion
import com.tnmeta.torymeta.my_page.NotificationSettingActivity
import com.tnmeta.torymeta.ui.CommonLoadingView
import com.tnmeta.torymeta.utils.PermissionHelper
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import org.greenrobot.eventbus.EventBus
import timber.log.Timber


class ToryWebFragment: BaseFragment() {
    companion object {
        private const val TAG = "ToryWebFragment"
        private const val ARG_URL = "url"
        private const val IS_BACK = "isback"

        @JvmStatic
        fun newInstance(url: String, isBack : Boolean) =
            ToryWebFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_URL, url)
                    putBoolean(IS_BACK, isBack)
                }
            }
    }

    private lateinit var onBackPressedCallback: OnBackPressedCallback
    private val loadingView: CommonLoadingView by lazy { CommonLoadingView(view as ViewGroup) }

    private var fileChooserCallback: ValueCallback<Array<Uri>>? = null
    private val fileChooserPermissionLauncher: ActivityResultLauncher<Array<String>> =
        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
            fileChooserCallback?.onReceiveValue(null)
            fileChooserCallback = null

        }
    private val fileChooserLauncher: ActivityResultLauncher<Intent> =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            fileChooserCallback?.onReceiveValue(WebChromeClient.FileChooserParams.parseResult(it.resultCode, it.data))
            fileChooserCallback = null
    }

    private lateinit var viewBinding: FragmentWebBinding


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)

        onBackPressedCallback = object: OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                onBackPressed()
            }
        }
        requireActivity().onBackPressedDispatcher.addCallback(this, onBackPressedCallback)
    }

    override fun onDetach() {
        super.onDetach()
        onBackPressedCallback.remove()
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = FragmentWebBinding.inflate(inflater, container, false)
        return viewBinding.root
    }

    override fun onDestroyView() {
        viewBinding.apply {
            webView.safeRemove()
        }

        super.onDestroyView()
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewBinding.apply {
            // 웹뷰 초기화
            webView.apply {
                activity = requireActivity()

                if (BuildConfig.DEBUG) {
                    clearCache(true)
                    doClearHistory = true
                }
            }
            webView.onBridgeEventListener = this@ToryWebFragment.onBridgeEventListener
            webView.onClientEventListener = object : ToryWebView.OnClientEventListener {
                override fun onPageStarted(view: WebView, url: String?) {
                    Timber.d(" url $url")
                    if (!webView.isFirstPageLoaded) {
                        loadingView.show(false)
                    }
                }

                override fun onPageFinished(view: WebView, url: String?) {
                }

                override fun onFirstPageLoaded(view: WebView) {
                    loadingView.hide()
                }

                override fun onProgressChanged(view: WebView, newProgress: Int) {
                }

                override fun onReceivedError(view: WebView, errorCode: Int, description: String?, failingUrl: String?) {
                }

                override fun onShowFileChooser(webView: WebView?, filePathCallback: ValueCallback<Array<Uri>>?, fileChooserParams: WebChromeClient.FileChooserParams?): Boolean {
                    Timber.d("onShowFileChooser")
                    try {
                        fileChooserCallback?.onReceiveValue(null)
                        fileChooserCallback = filePathCallback

                        Timber.d("onShowFileChooser ${PermissionHelper.isPermissionGranted(requireContext(), Manifest.permission.READ_EXTERNAL_STORAGE)}")

                        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            if (!PermissionHelper.isPermissionGranted(requireContext(), Manifest.permission.READ_MEDIA_IMAGES)) {
                                fileChooserPermissionLauncher.launch(arrayOf(Manifest.permission.READ_MEDIA_IMAGES))
                            } else {
                                val intent = fileChooserParams!!.createIntent()
                                fileChooserLauncher.launch(intent)
                            }
                        }else {
                            if (!PermissionHelper.isPermissionGranted(requireContext(), Manifest.permission.READ_EXTERNAL_STORAGE)) {
                                fileChooserPermissionLauncher.launch(arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE))
                            } else {
                                val intent = fileChooserParams!!.createIntent()
                                fileChooserLauncher.launch(intent)
                            }
                        }

                    }catch (e : Exception){
                        Timber.d("onShowFileChooser ${e.message}")
                    }

                    return true
                }
            }


            // load url
            arguments?.let {
                webView.loadFirstUrl(it.getString(ARG_URL, ""))
            }
        }
    }

    private val onBridgeEventListener = object:ToryWebView.OnBridgeEventListener {
        override fun onEvent(view: ToryWebView, event: Web.BridgeEvent, data: HashMap<String, Any?>) {
            try {
                Timber.d("onBridgeEventListener - $event")
                val repo = ToryApplication.getRepository(requireActivity())
                when (event) {
                    // 뒤로가기
                    Web.BridgeEvent.BACK -> {
                        try {
                            Log.i(TAG, "--- Bridge -> back")
                            activity?.finish()

                        }catch (e : Exception){
                            Timber.d(e.message)
                        }
                    }

                    // 로그인 완료, 메인으로 이동
                    Web.BridgeEvent.LOGIN_COMPLETED -> {
                        repo.apply {
                            setLoginToken(data["token"] as String)
                            setAutoLogin(data["isAutoLogin"] as Boolean)
                        }

                        activity?.setResult(Activity.RESULT_OK)
                        activity?.finish()
                    }

                    // 멤버 업데이트
                    Web.BridgeEvent.UPDATE_MEMBER -> {
                        repo.updateMember(ApiMode.UIMode.NONE)
                    }

                    // 로그아웃, 회원 탈퇴
                    Web.BridgeEvent.SIGN_OUT,
                    Web.BridgeEvent.WITHDRAWAL -> {
                        Timber.d("onBridgeEventListener - $event")
                        repo.signOut()

                        requireActivity().finishAffinity()
                        Intent(requireContext(), SplashActivity::class.java).run {
                            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                            startActivity(this)
                        }
                    }

                    // 로그인/알림 설정
                    Web.BridgeEvent.SETTING_NOTICE -> {
                        Intent(requireContext(), NotificationSettingActivity::class.java).run {
                            startActivity(this)
                        }
                    }

                    Web.BridgeEvent.NFT_SAVE_BC_TOKEN -> {
                        val dataValue = Gson().fromJson(data.toString(), NFTWebBridgeData::class.java)
                        val bcToken = dataValue.data["bcToken"].asString
                        if (bcToken.isNotEmpty()) {
                            repo.setBCToken(bcToken)
                        }
                    }

                    Web.BridgeEvent.NFT_BALANCE_REFRESH -> {
                        repo.updatePoint(ApiMode.UIMode.NONE)
                    }

                    Web.BridgeEvent.NFT_NATIVE_CLOSE -> {
                        activity?.finish()
                    }

                    Web.BridgeEvent.NFT_GUIDE_PAGE -> {
                        val dataValue = Gson().fromJson(data.toString(), NFTWebBridgeData::class.java)
                        val pageId = dataValue.data["pageId"].asString
                        repository.setNFTGuide(pageId.uppercase(), false)
                    }

//                    Web.BridgeEvent.CHNAGE_UNIVERSITY -> {
//                        activity?.finish()
//                        repository.initData()
//                            .subscribeBy(onNext = {
//                                toryApplication.isSeminarPopupOpenHistory = false
//                                toryApplication.initIAB(repository.toryItemList)
//
//                                repository.getEventInfo()
//                                    .subscribeBy(onNext = {
//                                        repository.eventArray.clear()
//                                        repository.eventArray.addAll(it.eventList)
//                                    }, onError = {})
//
//                                EventBus.getDefault().post(EventTypeBus(EventType.CLOSE))
//                                EventBus.getDefault().post(EventTypeBus(EventType.UPDATE))
//
//                            }, onError = {})
//                    }

                    Web.BridgeEvent.COMFIRE_CERTUNITYN -> {
                        val isModify = (data["isModify"] as String).toBoolean()
                        activity?.finish()

                        if(isModify) {
                            val params = BaseParam(InitVersion(BuildConfig.VERSION_NAME, Build.MODEL, Build.VERSION.RELEASE, Constants.BannerType)).parameter

                            repository.initData(params)
                                .subscribeBy(onNext = {
                                    toryApplication.initIAB(repository.toryItemList)

                                    repository.getEventInfo()
                                        .subscribeBy(onNext = {
                                            repository.eventArray.clear()
                                            repository.eventArray.addAll(it.eventList)
                                            EventBus.getDefault().post(EventTypeBus(EventType.CLOSE))
                                            EventBus.getDefault().post(EventTypeBus(EventType.UPDATE))
                                        }, onError = {})
                                }, onError = {})
                        }else {
                            val params = BaseParam(InitVersion(BuildConfig.VERSION_NAME, Build.MODEL, Build.VERSION.RELEASE, Constants.BannerType)).parameter
                            repository.initData(params)
                                .subscribeBy(onNext = {
                                    toryApplication.initIAB(repository.toryItemList)
                                    EventBus.getDefault().post(EventTypeBus(EventType.COMFIRE_CERTUNITYN))
                                }, onError = {})
                        }
                    }

                    Web.BridgeEvent.NATIVE_SHOW_BOARD_MODAL -> {
                        val viewModel = ViewModelProvider(this@ToryWebFragment)[CampusViewModel::class.java]

                        TogetherDialogFragment.TogetherDialogBuilder(childFragmentManager).apply {
                            setImageUrl(viewModel.getMyCampus().imgUrl)
                            setClickListener(object : CommonDialogInterface.OnClickListener {
                                override fun onClick(i: Int) {
                                    val url = when(i){
                                        R.id.tory_market_layout -> {
                                            firebaseAnalyticsMember( FirebaseParam.mobile_community_market)
                                            Web.Url.COMMUNITY_MARKET
                                        }
                                        R.id.tory_together_layout -> {
                                            firebaseAnalyticsMember( FirebaseParam.mobile_community_gother)
                                            Web.Url.COMMUNITY_GATHER
                                        }
                                        R.id.tory_talk_layout -> {
                                            firebaseAnalyticsMember( FirebaseParam.mobile_community_talk)
                                            Web.Url.COMMUNITY_TALK
                                        }
                                        R.id.tory_help_layout -> {
                                            firebaseAnalyticsMember( FirebaseParam.mobile_community_help)
                                            Web.Url.COMMUNITY_HELP
                                        }

                                        else -> {
                                            Web.Url.COMMUNITY_MARKET
                                        }
                                    }

                                    viewBinding.apply {
                                        arguments!!.putBoolean(IS_BACK, false)
                                        webView.loadFirstUrl(url)
                                    }
                                }
                            })
                        }.show()
                    }

                    Web.BridgeEvent.GO_FESTIVAL -> {
                        Timber.tag(TAG).d("GO_FESTIVAL")
                        CoroutineScope(Dispatchers.Main).launch {
                            repository.setIsShowBottomDialog(false)
                            EventBus.getDefault().post(EventTypeBus(EventType.TORYMETA_FESTIVAL))
                            activity?.finish()
                        }
                    }

                    else -> {
                        Log.i(TAG, "invalid bridge event: ${event.functionName}")
                    }
                }
            }catch (e : Exception){
                Timber.d(e.message)
            }
        }
    }


    fun onBackPressed() {
        Timber.d("webView onBackPressed")
        viewBinding.apply {

            val isBack = arguments?.getBoolean(IS_BACK, true)!!

            Timber.d("webView onBackPressed $isBack")
            if(isBack) {
                Timber.d("webView onBackPressed " + webView.canGoBack())

                /*
                if (webView.canGoBack()) {
                    webView.goBack()
                } else {
                    activity?.finish()
                }
                 */
                activity?.finish()
            }else {
                activity?.finish()
            }
        }
    }



}