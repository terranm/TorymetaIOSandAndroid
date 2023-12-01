//
//  MetaWorldViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/15.
//

import UIKit
/*
 [:*** Unity Release:]
 */
import UnityFramework

final class MetaWorldViewController: RefactoringBaseViewController<MetaWorldViewModel> {

    override var analyticsId: String { mAnalyticsId }

    private var mAnalyticsId = ""
    private var unityView: UIView?

    private var loadingView: CommonLoadingView?

    override init(nibName nibNameOrNil: String? = nil,
                  bundle nibBundleOrNil: Bundle? = nil,
                  viewModel: MetaWorldViewModel) {
        super.init(viewModel: viewModel)
        AppConfigure.lockOrientation(.landscape)
        unity.registUnityToNative(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
    }

    override func bind(_ viewModel: MetaWorldViewModel) {
        super.bind(viewModel)
        viewModel.metaworldSceneStatus
            .bind(onNext: { [weak self] in
                print("⚽️: \($0)")
                switch $0 {
                case .university(uniCode: let uniCode):
                    self?.mAnalyticsId = AnalyticsManager.recommendMeta
                    self?.translateUniWorldScene(uniCode: uniCode)
                    self?.showLoadingView(window: self?.unity.unityWindow)
                case .chattingLounge(tableID: let tableID, loungeVideoURL: let loungeVideoURL):
                    self?.mAnalyticsId = AnalyticsManager.toryLounge
                    self?.translateChattingLounge(tableId: tableID, loungeVideoUrl: loungeVideoURL)
                    self?.showLoadingView(window: self?.unity.unityWindow)
                case .lobby(loungeVideoURL: let loungeVideoURL):
                    self?.mAnalyticsId = AnalyticsManager.toryLounge
                    self?.translateLobby(vedioUrl: loungeVideoURL)
                    self?.showLoadingView(window: self?.unity.unityWindow)
                case .festival(let loungeVideoURL):
                    self?.mAnalyticsId = AnalyticsManager.toryLounge
                    self?.translateFestiival(vedioUrl: loungeVideoURL)
                    self?.showLoadingView(window: self?.unity.unityWindow)
                case .seminar(roomID: let roomID,
                              unitySeminarID: let unitySeminarID,
                              seminarURL: let seminarURL,
                              title: let title,
                              videoStartTime: let videoStartTime):
                    self?.translateSeminar(roomId: roomID,
                                           unitySeminarId: unitySeminarID,
                                           seminarUrl: seminarURL,
                                           title: title,
                                           videoStartTime: videoStartTime)
                    self?.showLoadingView(window: self?.unity.unityWindow)
                }

            })
            .disposed(by: disposeBag)
    }

    private func showLoadingView(window: UIWindow?) {
        loadingView = CommonLoadingView(window: window, milliseconds: 0)
        loadingView?.show()
    }

    private func hideLoadingView() {
        loadingView?.dismiss()
        loadingView = nil
    }

    /*
     [:*** Unity Release:]
     */
    private func translateUniWorldScene(uniCode: String) {
        unity.launchUnity()
        let switchSceneInfo = SwitchSceneInfo().getUniversityData(universityCode: uniCode)
        unity.callToUnityFunction(.switchUniversity, switchSceneInfo)
    }

    private func translateChattingLounge(tableId: String, loungeVideoUrl: String) {
        unity.launchUnity()
        let switchSceneInfo = SwitchSceneInfo().getChattingLoungeData(url: loungeVideoUrl, tableId: tableId)
        unity.callToUnityFunction(.switchChattingLounge, switchSceneInfo)
    }

    private func translateLobby(vedioUrl: String) {
        unity.launchUnity()
        let switchSceneInfo = SwitchSceneInfo().getLobbyData(url: vedioUrl)
        unity.callToUnityFunction(.switchLobby, switchSceneInfo)
    }

    private func translateFestiival(vedioUrl: String) {
        unity.launchUnity()
        let switchSceneInfo = SwitchSceneInfo().getFestivalData(url: vedioUrl)
        unity.callToUnityFunction(.switchFestival, switchSceneInfo)
    }

    private func translateSeminar(roomId: String,
                                  unitySeminarId: String,
                                  seminarUrl: String,
                                  title: String,
                                  videoStartTime: String) {
        unity.launchUnity()
        let switchSceneInfo = SwitchSceneInfo().getSeminarData(url: seminarUrl,
                                                               roomType: roomId,
                                                               roomId: unitySeminarId,
                                                               roomTitle: title,
                                                               videoStartTime: videoStartTime)
        unity.callToUnityFunction(.switchSeminar, switchSceneInfo)
    }

    private func unityLayout() {
        unityView = unity.unityView

        unityView?.subviews.forEach {
            $0.removeFromSuperview()
        }
        guard let unityView = unityView else { return }

        view.addSubview(unityView)
        unityView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        window?.makeKeyAndVisible()
        rootViewController?.setNeedsStatusBarAppearanceUpdate()
    }

    func joinByPush(_ tableID: String?) {
        guard let tableID else { return }
        unity.callToUnityFunction(.joinByPush, JoinByPush(tableId: tableID))
    }

    func disconnectServer() {
        unity.callToUnityFunction(.disconnectServer)
    }
}

extension MetaWorldViewController: NativeCallsProtocol {
    func showHostMainWindow(_ color: String!) {}

    // swiftlint:disable cyclomatic_complexity function_body_length
    func sendMessage(toMobileApp message: String!) {
        print("Send To Unity Message: \(message ?? "")")

        let convertData = unity.getUnityData(jsonStr: message)
        switch convertData.functionName {
            /*
             life Cyclex
             */
        case "OnDestroy", "Awake":
            break
        case "Start":
            unityLayout()
            hideLoadingView()
        case "NativeBack":
            AppConfigure.lockOrientation(.portrait)
            self.dismiss(animated: true)
        case "NativeShowModal":
            let bridgeData = try? JSONDecoder()
                .decode(UnityInfoWrapper<FromUnityShowModal>.self, from: convertData.data)
            guard let bridgeData = bridgeData?.value else { return }
            switch bridgeData.buttons.count {
            case 1:
                CommonModal.Builder()
                    .setTitle(bridgeData.title)
                    . setMessage(bridgeData.description)
                    .setPositiveButton(bridgeData.buttons[0].title) { [weak self] in
                        guard let self = self else { return }
                        let modalButtonTapAttr = ModalButtonTapActionAttribute(actionId:
                                                                                bridgeData.buttons[0].actionId)
                        self.unity.callToUnityFunction(.modalButtonTap, modalButtonTapAttr)
                        $0.dismiss(animated: true)
                    }
                    .setPositiveButtonColor(UIColor(bridgeData.buttons[0].color))
                    .build()
                    .show()

            case 2:
                CommonModal.Builder()
                    .setTitle(bridgeData.title)
                    .setMessage(bridgeData.description)
                    .setNagativeButton(bridgeData.buttons[0].title) { [weak self] in
                        guard let self = self else { return }
                        let modalButtonTapAttr = ModalButtonTapActionAttribute(actionId:
                                                                                bridgeData.buttons[0].actionId)
                        self.unity.callToUnityFunction(.modalButtonTap, modalButtonTapAttr)
                        $0.dismiss(animated: true)
                    }
                    .setNagativeButtonColor(UIColor(bridgeData.buttons[0].color))
                    .setPositiveButton(bridgeData.buttons[1].title) { [weak self] in
                        guard let self = self else { return }
                        let modalButtonTapAttr = ModalButtonTapActionAttribute(actionId:
                                                                                bridgeData.buttons[1].actionId)
                        self.unity.callToUnityFunction(.modalButtonTap, modalButtonTapAttr)
                        $0.dismiss(animated: true)
                    }
                    .setPositiveButtonColor(UIColor(bridgeData.buttons[1].color))
                    .build()
                    .show()

            default: break
            }
        case "NativeShowChattingModal":
            break
        case "FormCall":
            let formCall = try? JSONDecoder()
                .decode(UnityInfoWrapper<FromUnityFormCall<FromUnityEmpty>>.self, from: convertData.data)
            switch formCall?.value?.form {
            case "ChatList":
                let viewModel = ChattingLoungeChattingListViewModel()
                let viewController = ChattingLoungeChattingListViewController(viewModel: viewModel)
                self.presentViewController(viewController: viewController,
                                           modalTransitionStyle: .crossDissolve,
                                           modalPresentationStyle: .overFullScreen,
                                           backgroundColor: .clear)
            case "ChatCreate":
                let viewModel = ChattingLoungeChattingEntranceViewModel()
                let viewController = ChattingLoungeChattingEntranceViewController(viewModel: viewModel)
                viewController.setCompleteDelegate { [weak self] in
                    self?.unity.callToUnityFunction(.createChattingRoomInfo, $0)
                }
                self.presentViewController(viewController: viewController,
                                           modalTransitionStyle: .crossDissolve,
                                           modalPresentationStyle: .overFullScreen,
                                           backgroundColor: .togetherBlack.withAlphaComponent(0.3))
            case "PasswordInput":
                let passwordData = try? JSONDecoder()
                    .decode(UnityInfoWrapper<FromUnityFormCall<FromUnityChattingLoungePassword>>.self,
                            from: convertData.data).value?.option

                let viewModel = ChattingLoungePasswordViewModel(password: passwordData?.password,
                                                                isBackgroundClear: false)
                let viewController = ChattingLoungePasswordViewController(viewModel: viewModel)
                viewController.setEntranceAbleDelegate { [weak self] in
                    self?.unity.callToUnityFunction(.chattingLoungePasswordEntrance)
                }
                self.presentViewController(viewController: viewController,
                                           modalTransitionStyle: .crossDissolve,
                                           modalPresentationStyle: .overFullScreen,
                                           backgroundColor: .clear)
            case "ParticipantsList":
                let participantsInfoData = try? JSONDecoder()
                    .decode(UnityInfoWrapper<FromUnityFormCall<FromUnityParticipantsInformation>>.self,
                            from: convertData.data).value?.option
                guard let participantsInfoData = participantsInfoData else { return }
                let viewModel = ChattingLoungeParticipantsListViewModel(participantsInfo: participantsInfoData)
                let viewController = ChattingLoungeParticipantsListViewController(viewModel: viewModel)
                self.presentViewController(viewController: viewController,
                                           modalTransitionStyle: .crossDissolve,
                                           modalPresentationStyle: .overFullScreen,
                                           backgroundColor: .clear)
            case "ParticipantsMenu":
                let userInteractionInfoData = try? JSONDecoder()
                    .decode(UnityInfoWrapper<FromUnityFormCall<FromUnityUserInteractionInformation>>.self,
                            from: convertData.data).value?.option
                let viewModel =
                    ChattingLoungeUserInteractionListViewModel(isHostAthority: userInteractionInfoData?.isOwner,
                                                               memberId: userInteractionInfoData?.memberIdInt)
                let viewController = ChattingLoungeUserInteractionListViewController(viewModel: viewModel)
                self.presentViewController(viewController: viewController,
                                           modalTransitionStyle: .crossDissolve,
                                           modalPresentationStyle: .overFullScreen,
                                           backgroundColor: .clear)
            default:
                break
            }
        case "RequireLoungeVideoUrl":
            _ = repository.getNewSeminarLoungeVideoURL()
                .take(1)
                .bind { [weak self] url in
                    print("📺 LoungeVideoUrl:: \(url)")
                    self?.unity.callToUnityFunction(.loungeVideoUrl, LoungeVideoUrlInfo(url: url))
                }
        case "RequireMember":
            let value = repository.member.value
            self.unity.callToUnityFunction(.passMember, value)

        default:
            print("NOT INVALIDE BRIDGE CALL")
        }
    }
}
