import Foundation
import WebKit
import RxSwift
import RxCocoa
import Reachability
import FirebaseMessaging

/*
 1. LoadingView 대응 -> 0
 2. Network Error View 대응 -> 0
 3. NavigationBar
 4. popUp에 대해서 대응
 */

/*
 Data를 전달하는 방식
 1. get
 2. injection
 3. bridge
 */

struct NavigationBarInfo {
    var isNavHide: Bool {
        navigationTitle.isEmpty ? true: false
    }
    let navigationTitle: String
    /*
     0 -> push
     1 -> present
     */
    var type: Int

    init() {
        self.navigationTitle = ""
        self.type = 0
    }

    init(navigationTitle: String, type: Int) {
        self.navigationTitle = navigationTitle
        self.type = type
    }

}

final class CommonWebViewController: RefactoringBaseViewController<CommonWebViewModel>, RetryEnabledProtocol {

    var retryContainerView: UIView { view }
    func processRetry() {
        /*
         로딩 시도
         */
        self.webView.load(with: urlProtocol?.getUrl())

        let reachability = try? Reachability()
        if reachability?.connection == .unavailable {
            CommonToast.Builder()
                .setMessage(localizable.commonWebNetworkError())
                .setBackgroundColor(.togetherBlack.withAlphaComponent(0.5))
                .build()
                .show()
        }
    }

    var mAnalytics = ""
    override var analyticsId: String { mAnalytics }

    let webView = CommonWebView(bridgeName: "tory")

    var urlProtocol: CommonURLProtocol?

    var loadingView: CommonLoadingView?

    var netWorkErrorView: CommonNetworkErrorView?

    /*
     popUp WebView
     */
    var popUpView: CommonWebView?

    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil,
         urlProtocol: CommonURLProtocol, viewModel: CommonWebViewModel) {
        super.init(viewModel: viewModel)
        registerBridge()
        /*
         WebViewLoad
         */
        self.urlProtocol = urlProtocol
        self.setAnalytics(urlProtocol: urlProtocol)

        self.webView.load(with: urlProtocol.getUrl())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if urlProtocol?.getUrl()?.lastPathComponent == "login" {
            PushNotificationManager.globalNavigationRelay?.accept(navigationController)
        }
    }

    override func bind(_ viewModel: CommonWebViewModel) {
        super.bind(viewModel)

        /*
         login Success....
         */
        viewModel.loginSuccess
            .flatMap { _ in
                viewModel.repository.toryInit()
            }
            .filter {
                $0.memberVO.memberId != 0
            }
            .bind(to: viewModel.repository.initData)
            .disposed(by: disposeBag)

        viewModel.translatePage
            .distinctUntilChanged()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                repository.updatePushToken()
                    .take(1)
                    .bind { [weak self] updateSucceed in
                        if updateSucceed == false {
                            self?.showTemporaryAlert()
                        }
                    }
                    .disposed(by: disposeBag)
                WDPermissionManager.shared.isPermissionPageShow {
                    if $0 {
                        let requestPermissionViewModel = RequestPermissionViewModel()
                        let requestPermissionViewController =
                            RequestPermissionViewController(viewModel: requestPermissionViewModel)
                        self.changeRootViewController(viewController: requestPermissionViewController)
                    } else {
                        let avatarReViewViewModel = AvatarPreviewViewModel()
                        let newMainViewModel = MainViewModel(avatarReViewViewModel)
                        let newMainViewController = MainViewController(viewModel: newMainViewModel)

                        self.changeRootViewController(viewController: newMainViewController)
                    }
                }
            })
            .disposed(by: disposeBag)

        /*
         update....
         */
        viewModel.memberUpdate
            .flatMap {
                viewModel.repository.updateMember()
            }
            .subscribe()
            .disposed(by: disposeBag)

        viewModel.poinitUpdate
            .flatMap {
                viewModel.repository.updatePoint()
            }
            .subscribe()
            .disposed(by: disposeBag)

        viewModel.myWriteUpdate
            .flatMap {
                viewModel.repository.updateMyWriteList()
            }
            .subscribe()
            .disposed(by: disposeBag)

        viewModel.myCommentUpdate
            .flatMap {
                viewModel.repository.updateMyComment()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    func controlShowHideNav(isHide: Bool, title: String = "") {
        self.navigationController?.setNavigationBarHidden(isHide, animated: false)
        if !title.isEmpty {
            self.title = title
        }
        self.navigationController?.navigationBar.layoutIfNeeded()
    }

    // swiftlint:disable function_body_length cyclomatic_complexity
    func registerBridge() {
        webView.addBridgeDelegate(CommonWebView.provideUI) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case "NAVITE_NAVIGATION_BAR_CONTROL":
                let data = try? JSONDecoder().decode(NavigationBarControlBridgeResultDto.self, from: $1)
                guard let bridgeData = data else { return }
                self.controlShowHideNav(isHide: bridgeData.isHide)
            case "NATIVE_SHOW_BOTTOM_MODAL":
                let data = try? JSONDecoder().decode(ShowBottomModalBridgeResultDto.self, from: $1)
                guard let bridgeData = data else { return }
                let cancel = bridgeData.actions[bridgeData.actions.count - 1]

                var actions = bridgeData.actions.map { action in
                    CommonBottomModalAction(title: action.title, titleColor: UIColor(action.color)) { _ in
                        self.provideAction(actionId: action.actionId)
                    }
                }
                actions.remove(at: actions.count - 1)
                CommonBottomModal.Builder()
                    .setActions(actions)
                    .setCancelMessage(cancel.title)
                    .build()
                    .show()
            case "NATIVE_SHOW_MODAL":
                let data = try? JSONDecoder().decode(ShowModalBridgeResultDto.self, from: $1)
                guard let bridgeData = data else { return }

                switch bridgeData.actions.count {
                case 1:
                    CommonModal.Builder()
                        .setTitle(bridgeData.title)
                        .setMessage(bridgeData.description)
                        .setPositiveButton(bridgeData.actions[0].title) {
                            self.provideAction(actionId: bridgeData.actions[0].actionId)
                            $0.dismiss(animated: true)
                        }
                        .setPositiveButtonColor(UIColor(bridgeData.actions[0].color))
                        .build()
                        .show()
                case 2:
                    CommonModal.Builder()
                        .setTitle(bridgeData.title)
                        .setMessage(bridgeData.description)
                        .setNagativeButton(bridgeData.actions[0].title) {
                            self.provideAction(actionId: bridgeData.actions[0].actionId)
                            $0.dismiss(animated: true)
                        }
                        .setNagativeButtonColor(UIColor(bridgeData.actions[0].color))
                        .setPositiveButton(bridgeData.actions[1].title) {
                            self.provideAction(actionId: bridgeData.actions[1].actionId)
                            $0.dismiss(animated: true)

                        }
                        .setPositiveButtonColor(UIColor(bridgeData.actions[1].color))
                        .build()
                        .show()
                default: return
                }
            case "NATIVE_SHOW_TOAST":
                let data = try? JSONDecoder().decode(ShowToastBridgeResultDto.self, from: $1)
                guard let bridgeData = data else { return }
                CommonToast.Builder()
                    .setMessage(bridgeData.message)
                    .setMessageColor(UIColor(bridgeData.fontColor))
                    .setBackgroundColor(UIColor(bridgeData.backgroundColor))
                    .build()
                    .show()
            case "NATIVE_LOADING_VIEW_SHOW":
                self.showLoading()
            case "NATIVE_LOADING_VIEW_HIDE":
                /*
                 호출이 정상적으로 동작하는지 확인
                 */
                self.hideLoading()
            case "NATIVE_SHOW_BOARD_MODAL":
                let boardSelectViewModel = BoardSelectViewModel()
                let boardSelectViewControlle = BoardSelectViewController(viewModel: boardSelectViewModel)
                boardSelectViewControlle.setDelegate { [weak self] in
                    guard let self = self else { return }
                    let url = ToryWebViewURL(path: $0)
                    let urlRequest = URLRequest(url: url.getUrl()!)
                    self.webView.load(urlRequest)
                }
                self.presentPanmodal(panModel: boardSelectViewControlle, backgroundColor: .clear)
            default:
                break
            }
        }

        webView.addBridgeDelegate(CommonWebView.common) { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case "goFestival":
                MainViewController.isFromFestival = true
                self.dismiss(animated: true) {
                    self.viewModel.festivalRelay.accept(())
                }

                /*
                 TORY
                 */
            case "dismiss":
                self.dismiss(animated: true)

            case "back":
                self.navigationController?.popViewController(animated: true)

            case "clickSignOut":
                /*
                 마이페이지 먼저 dismiss
                 */
                self.dismiss(animated: false) {
                    UserDefaults.standard.setValue("", forKey: "token")
                    UserDefaults.standard.setValue(false, forKey: "isAutoLogin")
                    UserDefaults.standard.setValue(0, forKey: "memberId")

                    PushNotificationManager.globalNavigationRelay?.accept(nil)
                    let onboardingViewController = OnboardingViewController(viewModel: RefactoringBaseViewModel())
                    self.changeRootViewController(viewController: onboardingViewController, backgroundColor: .togetherWhite)
                }

            case "noticeSetting":
                let viewModel = LoginAlarmSettingViewModel()
                let loginAlarmSettingViewController = LoginAlarmSettingViewController(viewModel: viewModel)

                self.pushViewController(viewController: loginAlarmSettingViewController,
                                        title: localizable.commonWebNotifySetting())

            case "clickWithdrawal":
                /*
                 마이페이지 먼저 dismiss
                 */
                self.dismiss(animated: false) {
                    UserDefaults.standard.setValue("", forKey: "token")
                    UserDefaults.standard.setValue(false, forKey: "isAutoLogin")
                    UserDefaults.standard.setValue(0, forKey: "memberId")

                    PushNotificationManager.globalNavigationRelay?.accept(nil)

                    let onboardingViewController = OnboardingViewController(viewModel: RefactoringBaseViewModel())
                    self.changeRootViewController(viewController: onboardingViewController, backgroundColor: .togetherWhite)
                }

            case "clickLogin":
                let data = try? JSONDecoder().decode(LoginBridgeResultDto.self, from: $1)
                guard let bridgeData = data else { return }

                UserDefaults.standard.setValue(bridgeData.token, forKey: WDUserDefaultManager.Key.token.rawValue)
                UserDefaults.standard.setValue(bridgeData.isAutoLogin,
                                               forKey: WDUserDefaultManager.Key.isAutoLogin.rawValue)

                self.viewModel.loginSuccess.accept(bridgeData.universityCode)

            case "changeMember":
                self.viewModel.memberUpdate.accept(())
            case "changePoint":
                self.viewModel.poinitUpdate.accept(())
            case "retryWrite":
                self.viewModel.myWriteUpdate.accept(())
            case "retryComment":
                self.viewModel.myCommentUpdate.accept(())
//            case "canChatting":
//                let data = try? JSONDecoder().decode(CanChattingBridgeResultDto.self, from: $1)
//                guard let bridgeData = data else { return }
//
//                let chattingViewController2 = ChattingViewController2(isNavigationCloseButtomShow: true)
//                let viewModel = ChattingViewModel2(
//                    channelId: Observable.just(bridgeData.chid),
//                    createMember: Observable.just(
//                        .init(
//                            sub: bridgeData.memberId,
//                            nm: bridgeData.nickName,
//                            profile: bridgeData.profile
//                        )
//                    )
//                )
//                chattingViewController2.bind(viewModel)
//                self.presentNavigationViewController(vc: chattingViewController2, title: "")
            case "comfire_certUniYn":
                let data = try? JSONDecoder().decode(SelectUniversityBridgeResultDto.self, from: $1)
                guard data != nil else { return }

                self.viewModel.memberUpdate.accept(())
                self.topMostViewController?.dismiss(animated: true)

                /*
                 NFT Page...
                 */
            case "NATIVE_SAVE_BC_TOKEN":
                let data = try? JSONDecoder().decode(SaveBcTokenBridgeResultDto.self, from: $1)
                guard let bridgeData = data else { return }
                UserDefaults.standard.setValue(bridgeData.data.bcToken, forKey: "bcToken")
            case "NATIVE_BALANCE_REFRESH":
                self.viewModel.poinitUpdate.accept(())
            case "NATIVE_CLOSE":
                /*
                 나중에 통합 하도록 하자
                 */
                self.dismiss(animated: true)
            case "NATIVE_VISIBLE_SET_GUIDE_PAGE":
                let data = try? JSONDecoder().decode(VisibleSetGuidePageBridgeResultDto.self, from: $1)
                guard let bridgeData = data else { return }
                UserDefaults.standard.setValue("false", forKey: bridgeData.data.pageId)
            case "NATIVE_MOVE_PAGE_RECHARGE_TORY_POINT":
                let pointChargeViewModel = PointChargeViewModel()
                let viewController = PointChargeViewController(viewModel: pointChargeViewModel)

                self.pushViewController(viewController: viewController, title: "")
            default:
                break
            }
        }

        webView.addBridgeDelegate(CommonWebView.provideData) { [weak self] functionName, _ in
            guard let self = self else { return }
            switch functionName {
            case "NATIVE_GET_MEMBER":
                self.provideData(self.repository.member.value)
            case "NATIVE_GET_POINT":
                self.provideData(self.repository.point.value)
            case "NATIVE_GET_UNIVERSITY_LIST":
                self.provideData(self.repository.universityList.value)
            case "NATIVE_GET_DEFAULT_IMG_LIST":
                self.provideData(self.repository.defaultImgUrlList.value)
            case "NAVITE_GET_MY_WRITE_LIST":
                self.provideData(self.repository.myWriteList.value)
            case "NATIVE_GET_MY_COMMENT_LIST":
                self.provideData(self.repository.myCommentList.value)
            case "NATIVE_GET_IS_SEMINAR_BANNER_SHOW":
                self.provideData(self.repository.isSeminarBannerShow.value)
            case "NATIVE_GET_IS_SEMINAR_ON_AIR":
                self.provideData(self.repository.isSeminarOnAirShow.value)
            case "NATIVE_GET_IS_PUSH_AGREE":
                self.provideData(self.repository.isPushAgree.value)
            case "NATIVE_HAS_NOCH":
                let hasNoch = self.window?.safeAreaInsets.top ?? 0.0
                self.provideData("\(hasNoch)")
            default:
                break
            }
        }
    }

    func provideAction(actionId: String) {
        self.webView.evaluateJavaScript("doAction('\(actionId)')")
    }

    func provideData(_ data: Encodable) {
        let safeJsonStr = WDHelper.safeEncoding(data: data)
        self.webView.evaluateJavaScript("receiveData('\(safeJsonStr)')")
    }

    func provideData(_ data: String) {
        self.webView.evaluateJavaScript("receiveData('\(data)')")
    }

    func setAnalytics(urlProtocol: CommonURLProtocol) {
        let distinguish = urlProtocol.distinguish
        /*
         TORYURL
         */
        switch distinguish {
        case ToryWebViewURLType.setting.path:
            mAnalytics = AnalyticsManager.setting
        case ToryWebViewURLType.notice.path:
            mAnalytics = AnalyticsManager.notice
        case ToryWebViewURLType.boardTalk.path:
            mAnalytics = AnalyticsManager.communityTalk
        case ToryWebViewURLType.boardWe.path:
            mAnalytics = AnalyticsManager.communityGether
        case ToryWebViewURLType.boardHelp.path:
            mAnalytics = AnalyticsManager.communityHelp
        case ToryWebViewURLType.boardMarket.path:
            mAnalytics = AnalyticsManager.communityMarket
        case ToryWebViewURLType.event.path:
            mAnalytics = AnalyticsManager.schoolEvent
        case ToryWebViewURLType.food.path:
            mAnalytics = AnalyticsManager.schoolMeal

        case NFTWebViewURL.nftBottomTap:
            mAnalytics = AnalyticsManager.nft
        default:
            break
        }

        /*
         NFTURL
         */
        switch distinguish {
        case NFTWebViewURL.nftBottomTap:
            mAnalytics = AnalyticsManager.nft
        default:
            break
        }
    }

    override func attribute() {
        super.attribute()

        webView.navigationDelegate = self
        webView.uiDelegate = self

        let token = userDefaultManager.token ?? ""
        let fcmToken = Messaging.messaging().fcmToken ?? ""
        let currentVersion = AppConfigure.currentAppVersion
        let osName = AppConfigure.osName
        let isProductRelease = AppConfigure.isProductRelease
        let hasNoch = window?.safeAreaInsets.top ?? 0.0

        let currentLanguageCode = Locale.preferredLanguages.first?.split(separator: "-").first ?? "ko"
        let script = """
            window.version="\(currentVersion)";
            window.token="\(token)";
            window.fcmToken="\(fcmToken)"
            window.os="\(osName)";
            window.isProductRelease="\(isProductRelease)";
            window.hasNoch="\(hasNoch)";
            window.languageCode="\(currentLanguageCode)";
        """
        webView.injection(script)
    }

    override func layout() {
        super.layout()

        view.addSubview(webView)

        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
    deinit {
        hideLoading()
    }
}

extension CommonWebViewController: WKNavigationDelegate {

    func showLoading(milliseconds: Int = 800) {
        if loadingView == nil {
            loadingView = CommonLoadingView(milliseconds: milliseconds)
            loadingView?.show()
        }
    }

    func hideLoading() {
        loadingView?.dismiss()
        loadingView = nil
    }

    /*
     web 페이지의 로딩이 시작될때 호출되는 함수
     */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoading(milliseconds: 0)
    }

    /*
     web에서의 로딩이 완료되었을때 호출되는 함수
     */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoading()
    }

    /*
     Network가 연결이 안되있을때 호출 되는 함수
     */
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        hideLoading()
        CommonNetworkErrorView.Builder()
            .build(host: self)
            .show()
    }
}

/*
 POP_UP
 */
extension CommonWebViewController: WKUIDelegate {

    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        /*
         새로운 웹뷰 생성 그리고 화면위에 붙여준다.
         */
        self.controlShowHideNav(isHide: false, title: localizable.commonWebAuthorize())
        let exitNavigationButton = UIImageView()
        exitNavigationButton.image = R.image.default_banner_exit()
        exitNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: exitNavigationButton)
        exitNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.closeNavigationBar()
                self.deinitPopUp(webView: self.popUpView!)
            })
            .disposed(by: disposeBag)
//        self.navigationItem
//        self.navigationItem.leftBarButtonItems = navManager.setItem(
//            itemName: R.image.default_banner_exit.name,
//            itemSize: 44
//        ) { [weak self] _ in
//            guard let self = self else { return }
//            self.closeNavigationBar()
//            self.deinitPopUp(webView: self.popUpView!)
//        }

        popUpView = CommonWebView(frame: view.bounds, configuration: configuration)
        /*
         Navigation에 대한 리슨은 듣지 않겠다.
         */
//        popUpView?.navigationDelegate = self
        popUpView?.uiDelegate         = self
        view.addSubview(popUpView!)
        popUpView?.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        return popUpView
    }

    func webViewDidClose(_ webView: WKWebView) {
        /*
         삭제
         */
        self.closeNavigationBar()
        self.deinitPopUp(webView: webView)
    }

    func deinitPopUp(webView: WKWebView) {
        /*
         삭제
         */
        if webView === popUpView {
            self.popUpView?.removeFromSuperview()
//            popUpView?.navigationDelegate = nil
            popUpView?.uiDelegate = nil
            self.popUpView = nil
        }
    }

    func closeNavigationBar() {
        self.controlShowHideNav(isHide: true)
        self.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.leftBarButtonItem = nil
    }
}

// MARK: Push notification 관련 처리
extension CommonWebViewController {
    private func showTemporaryAlert() {
        CommonModal.Builder()
            .setTitle(localizable.splashErrorTitle())
            .setMessage(localizable.splashErrorMessage())
            .setPositiveButton(localizable.splashRestartMessage()) {
                $0.dismiss(animated: true)
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
            }
            .build()
            .show()
    }
}
