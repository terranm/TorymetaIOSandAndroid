//
//  SeminarEntranceManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/03.
//

import UIKit
import RxSwift
import RxCocoa

final class SeminarManager {

    typealias ParticipateParams = (roomId: Int, password: String)

    struct SeminarTagAppearance {
        let tagStr: String
        let tagColorStr: String
        let countInfoString: String
    }

    struct SeminarEntranceButtonAppearance {
        let isProfileHidden: Bool
        let isMyTagHidden: Bool
        let profileImgURL: String
        let buttonTitle: String
        let buttonBackgroundColor: UIColor
        init() {
            self.isProfileHidden = false
            self.isMyTagHidden = false
            self.profileImgURL = ""
            self.buttonTitle = ""
            self.buttonBackgroundColor = .clear
        }
        init(isProfileHidden: Bool,
             isMyTagHidden: Bool,
             profileImgUrl: String,
             buttonStr: String,
             buttonBackgroundColor: UIColor) {
            self.isProfileHidden = isProfileHidden
            self.isMyTagHidden = isMyTagHidden
            self.profileImgURL = profileImgUrl
            self.buttonTitle = buttonStr
            self.buttonBackgroundColor = buttonBackgroundColor
        }
    }

    enum SeminarAcessableState {
        case enter(_ id: Int)
        case secretEnter(_ id: Int)
        case enterMySeminar(_ id: Int)
        case apply(_ id: Int)
    }

    private let seminarModel = SeminarManagerModel()

    private func enterState(state: SeminarManager.SeminarAcessableState, viewController: UIViewController?) {
        switch state {
        case .enter(let id):
            let parmas = (id, "")
            self.seminarModel.participate.accept(parmas)
        case .secretEnter(let id):
            let viewModel = SeminarPwModalViewModel()
            let modal = SeminarPwModal(viewModel: viewModel)
            modal.setCompleteDelegate { [weak self] in
                guard let self = self else { return }
                if !($0?.isEmpty ?? false) {
                    let params = (id, $0 ?? "")
                    self.seminarModel.participate.accept(params)
                }
            }
            viewController?.presentPanmodal(panModel: modal, backgroundColor: .togetherWhite)
        case .enterMySeminar(let id):
            self.seminarModel.mySeminarParticipate.accept(id)
        case .apply(let id):
            self.seminarModel.apply.accept(id)
        }
    }
    private func accepNeedInformationToSeminar(title: String, videoStartTime: String, isSecret: Bool, seminarID: Int) {
        let needInformationToSeminar = NeedInformationToSeminar(title: title,
                                                                videoStartTime: videoStartTime,
                                                                isSecret: isSecret,
                                                                seminarID: seminarID)
        self.seminarModel.needInformationToSeminar.accept(needInformationToSeminar)
    }

    private func applyResultUpdate(needInformationToSeminar: NeedInformationToSeminar) {
        if WDHelper.getRootViewController()?.depthViewController is MainViewController {
            self.seminarModel.repository.newMainSeminarReload.accept(())
        }
        self.seminarModel.repository.seminarMainReload.accept(())
        self.seminarModel.repository.seminarSearchReload.accept(needInformationToSeminar.seminarID)
    }

    private func presentEnterModal(state: SeminarAcessableState, delegate: @escaping (SeminarAcessableState) -> Void) {
        CommonModal.Builder()
            .setMessage(localizable.seminarManagerEntrance())
            .setNagativeButton(localizable.seminarManagerIgnore()) {
                $0.dismiss(animated: true)
            }
            .setPositiveButton(localizable.seminarManagerConfirm()) {
                /*
                 Unity 진입.....
                 */
                $0.dismiss(animated: true) {
                    delegate(state)
                }
            }
            .build()
            .show()
    }

    private func presentAlertModal(message: String) {
        CommonModal.Builder()
            .setMessage(message)
            .setPositiveButton(localizable.loungeManagerConfirm()) {
                $0.dismiss(animated: true)
            }
            .build()
            .show()
    }

    private func presentApplyModal(title: String, message: String) {
        CommonModal.Builder()
            .setTitle(title)
            .setTitleFont(.bold16)
            .setMessage(message)
            .setMessageFont(.regular12)
            .setMessageColor(.togetherGray2)
            .setPositiveButton(localizable.loungeManagerConfirm()) { $0.dismiss(animated: true) }
            .setPositiveButtonColor(.togetherPurple)
            .build()
            .show()
    }
}

extension SeminarManager {
    /*
     메인화면
     */
    func setTagUI(data: LiveSeminarListResultDto.Item, delegate: @escaping (SeminarTagAppearance) -> Void) {
        let result = getTagUIResource(tagState: data.tagState,
                                      reqCnt: data.requestParticipation,
                                      currentCnt: data.currentParticipation,
                                      maxCnt: data.maxParticipation)
        delegate(result)
    }

    func setTagUI(data: SeminarListResultDto.Item, delegate: @escaping (SeminarTagAppearance) -> Void) {
        let result = getTagUIResource(tagState: data.tagState,
                                      reqCnt: data.requestParticipation,
                                      currentCnt: data.currentParticipation,
                                      maxCnt: data.maxEnterCount)
        delegate(result)
    }

    func setTagUI(data: SeminarDetailResultDto, delegate: @escaping (SeminarTagAppearance) -> Void) {
        let result = getTagUIResource(tagState: data.tagState)
        delegate(result)
    }

    func setTagUI(tagState: SeminarTagState, delegate: @escaping (SeminarTagAppearance) -> Void) {
        let result = getTagUIResource(tagState: tagState)
        delegate(result)
    }

    private func getTagUIResource(tagState: SeminarTagState,
                                  reqCnt: Int = 0,
                                  currentCnt: Int = 0,
                                  maxCnt: Int = 0) -> SeminarTagAppearance {
        switch tagState {
        case .standBy:
            return SeminarTagAppearance(tagStr: localizable.seminarManagerReady(),
                                        tagColorStr: "#9E9E9E",
                                        countInfoString: "\(reqCnt) / \(maxCnt)")
        case .start:
            return SeminarTagAppearance(tagStr: localizable.seminarManagerInProgress(),
                                        tagColorStr: "#FD6E6E",
                                        countInfoString: "\(currentCnt) / \(maxCnt)")
        case .closed:
            return SeminarTagAppearance(tagStr: localizable.seminarManagerFinish(),
                                        tagColorStr: "#37424D",
                                        countInfoString: "\(currentCnt) / \(maxCnt)")
        case .confirm:
            return SeminarTagAppearance(tagStr: localizable.seminarManagerConfirmed(),
                                        tagColorStr: "#FD6E6E",
                                        countInfoString: "\(currentCnt) / \(maxCnt)")
        case .reject:
            return SeminarTagAppearance(tagStr: localizable.seminarManagerDenied(),
                                        tagColorStr: "#FF0000",
                                        countInfoString: "\(currentCnt) / \(maxCnt)")
        case .confirmWait:
            return SeminarTagAppearance(tagStr: localizable.seminarManagerPending(),
                                        tagColorStr: "#9E9E9E",
                                        countInfoString: "\(currentCnt) / \(maxCnt)")
        }
    }
}

extension SeminarManager {
    func setEntranceButtonUI(data: LiveSeminarListResultDto.Item,
                             delegate: @escaping (SeminarEntranceButtonAppearance) -> Void) {
        let result = getEntranceButtonUIResource(teacherId: data.teacherId,
                                                 isSecret: data.isSecret,
                                                 isParticipate: data.isParticipate,
                                                 tagState: data.tagState,
                                                 teacherImageUrl: data.teacherImageUrl)
        delegate(result)
    }

    func setEntranceButtonUI(data: SeminarListResultDto.Item,
                             delegate: @escaping (SeminarEntranceButtonAppearance) -> Void) {
        let result = getEntranceButtonUIResource(teacherId: data.teacherId,
                                                 isSecret: data.isSecret,
                                                 isParticipate: data.isParticipate,
                                                 tagState: data.tagState,
                                                 teacherImageUrl: data.teacherImageUrl)
        delegate(result)
    }

    func setEntranceButtonUI(data: SeminarDetailResultDto,
                             delegate: @escaping (SeminarEntranceButtonAppearance) -> Void) {
        let result = getEntranceButtonUIResource(teacherId: data.teacherId,
                                                 isSecret: data.isSecret,
                                                 isParticipate: data.isParticipate,
                                                 tagState: data.tagState,
                                                 teacherImageUrl: "")
        delegate(result)
    }

    private func getEntranceButtonUIResource(teacherId: Int,
                                             isSecret: Bool,
                                             isParticipate: Bool,
                                             tagState: SeminarTagState,
                                             teacherImageUrl: String) -> SeminarEntranceButtonAppearance {
        let repository = WDRepository.shared
        /*
         경우의 수8
         */
        let isMy = repository.member.value.memberId == teacherId
        let isSeminarBefore = tagState == .standBy
        let isSeminarStart = tagState == .start
        let isSeminarEnd = tagState == .closed
        if !isMy && !isSecret && (isSeminarBefore || isSeminarEnd) {
            return SeminarEntranceButtonAppearance(isProfileHidden: false,
                                                   isMyTagHidden: true,
                                                   profileImgUrl: teacherImageUrl,
                                                   buttonStr: localizable.seminarManagerJoin(),
                                                   buttonBackgroundColor: .togetherGray3)
        }
        if !isMy && !isSecret && isSeminarStart {
            return SeminarEntranceButtonAppearance(isProfileHidden: false,
                                                   isMyTagHidden: true,
                                                   profileImgUrl: teacherImageUrl,
                                                   buttonStr: localizable.seminarManagerJoin(),
                                                   buttonBackgroundColor: .togetherPurple)
        }
        if !isMy && isSecret && isParticipate && (isSeminarBefore || isSeminarEnd) {
            return SeminarEntranceButtonAppearance(isProfileHidden: false,
                                                   isMyTagHidden: true,
                                                   profileImgUrl: teacherImageUrl,
                                                   buttonStr: localizable.seminarManagerJoin(),
                                                   buttonBackgroundColor: .togetherGray3)
        }
        if !isMy && isSecret && isParticipate && isSeminarStart {
            return SeminarEntranceButtonAppearance(isProfileHidden: false,
                                                   isMyTagHidden: true,
                                                   profileImgUrl: teacherImageUrl,
                                                   buttonStr: localizable.seminarManagerJoin(),
                                                   buttonBackgroundColor: .togetherPurple)
        }
        if !isMy && isSecret && !isParticipate && isSeminarBefore {
            return SeminarEntranceButtonAppearance(isProfileHidden: false,
                                                   isMyTagHidden: true,
                                                   profileImgUrl: teacherImageUrl,
                                                   buttonStr: localizable.seminarManagerRequest(),
                                                   buttonBackgroundColor: .togetherPurple)
        }
        if !isMy && isSecret && !isParticipate && (isSeminarStart || isSeminarEnd) {
            return SeminarEntranceButtonAppearance(isProfileHidden: false,
                                                   isMyTagHidden: true,
                                                   profileImgUrl: teacherImageUrl,
                                                   buttonStr: localizable.seminarManagerRequest(),
                                                   buttonBackgroundColor: .togetherGray3)
        }
        if isMy && (isSeminarBefore || isSeminarStart) {
            return SeminarEntranceButtonAppearance(isProfileHidden: true,
                                                   isMyTagHidden: false,
                                                   profileImgUrl: "",
                                                   buttonStr: localizable.seminarManagerEnter(),
                                                   buttonBackgroundColor: .togetherPurple)
        }
        if isMy && isSeminarEnd {
            return SeminarEntranceButtonAppearance(isProfileHidden: true,
                                                   isMyTagHidden: false,
                                                   profileImgUrl: "",
                                                   buttonStr: localizable.seminarManagerEnter(),
                                                   buttonBackgroundColor: .togetherGray3)
        }
        return SeminarEntranceButtonAppearance()
    }
}

extension SeminarManager {
    /*
     entrance logic
     */
    private func entrance(_ id: Int,
                          _ pageData: SeminarDetailResultDto,
                          _ delegate: @escaping (SeminarAcessableState) -> Void) {
        entrance(EntranceInfo(id: id,
                              teacherId: pageData.teacherId,
                              isSecret: pageData.isSecret,
                              isParticipate: pageData.isParticipate,
                              tagState: pageData.tagState)) {
            delegate($0)
        }
//        entrance(id: id,
//                 teacherId: pageData.teacherId,
//                 isSecret: pageData.isSecret,
//                 isParticipate: pageData.isParticipate,
//                 tagState: pageData.tagState) {
//            delegate($0)
//        }
    }

    private func entrance(_ item: LiveSeminarListResultDto.Item,
                          _ delegate: @escaping (SeminarAcessableState) -> Void) {
        entrance(EntranceInfo(id: item.id,
                              teacherId: item.teacherId,
                              isSecret: item.isSecret,
                              isParticipate: item.isParticipate,
                              tagState: item.tagState)) {
            delegate($0)
        }
//        entrance(id: item.id,
//                 teacherId: item.teacherId,
//                 isSecret: item.isSecret,
//                 isParticipate: item.isParticipate,
//                 tagState: item.tagState) {
//            delegate($0)
//        }
    }

    private func entrance(_ item: SeminarListResultDto.Item, _ delegate: @escaping (SeminarAcessableState) -> Void) {
        entrance(EntranceInfo(id: item.id,
                              teacherId: item.teacherId,
                              isSecret: item.isSecret,
                              isParticipate: item.isParticipate,
                              tagState: item.tagState)) {
            delegate($0)
        }
//        entrance(id: item.id,
//                 teacherId: item.teacherId,
//                 isSecret: item.isSecret,
//                 isParticipate: item.isParticipate,
//                 tagState: item.tagState) {
//            delegate($0)
//        }
    }

    struct EntranceInfo {
        let id: Int
        let teacherId: Int
        let isSecret: Bool
        let isParticipate: Bool
        let tagState: SeminarTagState
    }
    private func entrance(_ entranceInfo: EntranceInfo, delegate: @escaping (SeminarAcessableState) -> Void) {
        let repository = WDRepository.shared

        let isAvatarExit = repository.hasAvaterAttr.value
        let isMy = repository.member.value.memberId == entranceInfo.teacherId
        let isSeminarBefore = entranceInfo.tagState == .standBy
        let isSeminarStart = entranceInfo.tagState == .start
        let isSeminarEnd = entranceInfo.tagState == .closed

        if isAvatarExit && !isMy && !entranceInfo.isSecret && isSeminarBefore {
            presentAlertModal(message: localizable.seminarManagerEnterDeniedNotOpen())
        }
        if isAvatarExit && !isMy && !entranceInfo.isSecret && isSeminarStart {
            let state = SeminarAcessableState.enter(entranceInfo.id)
            presentEnterModal(state: state, delegate: delegate)
        }
        if isAvatarExit && !isMy && !entranceInfo.isSecret && isSeminarEnd {
            presentAlertModal(message: localizable.seminarManagerEnterDeniedClosed())
        }
        if isAvatarExit && !isMy && entranceInfo.isSecret && entranceInfo.isParticipate && isSeminarBefore {
            presentAlertModal(message: localizable.seminarManagerEnterDeniedClosed())
        }
        if isAvatarExit && !isMy && entranceInfo.isSecret && entranceInfo.isParticipate && isSeminarStart {
            let state = SeminarAcessableState.secretEnter(entranceInfo.id)
            delegate(state)
        }
        if isAvatarExit && !isMy && entranceInfo.isSecret && entranceInfo.isParticipate && isSeminarEnd {
            presentAlertModal(message: localizable.seminarManagerEnterDeniedClosed())
        }
        if isAvatarExit && !isMy && entranceInfo.isSecret && !entranceInfo.isParticipate && isSeminarBefore {
            let state = SeminarAcessableState.apply(entranceInfo.id)
            delegate(state)
        }
        if isAvatarExit && !isMy && entranceInfo.isSecret && !entranceInfo.isParticipate && isSeminarStart {
            presentAlertModal(message: localizable.seminarManagerNotApplied())
        }
        if isAvatarExit && !isMy && entranceInfo.isSecret && !entranceInfo.isParticipate && isSeminarEnd {
            presentAlertModal(message: localizable.seminarManagerApplyDeniedClosed())
        }
        if isAvatarExit && isMy && isSeminarEnd {
            presentAlertModal(message: localizable.seminarManagerEnterDeniedClosed())
        }
        if isAvatarExit && isMy && (isSeminarBefore || isSeminarStart) {
            let state = SeminarAcessableState.enterMySeminar(entranceInfo.id)
            presentEnterModal(state: state, delegate: delegate)
        }
        if !isAvatarExit {
            presentAlertModal(message: localizable.loungeManagerSelectAvatar())
        }
    }
}

/*
 세미나 EntryPoint
 */
extension SeminarManager {
    func seminarButtonTapUseCase(viewController: UIViewController?,
                                 item: LiveSeminarListResultDto.Item) -> Observable<Void> {
        return Observable.just(())
            .flatMapLatest { [weak self, weak viewController] in
                guard let mViewController = viewController else { return Observable<Void>.empty() }
                guard let self = self else { return Observable<Void>.empty() }
                self.accepNeedInformationToSeminar(title: item.title,
                                              videoStartTime: item.startAt,
                                              isSecret: item.isSecret,
                                              seminarID: item.id)
                self.entrance(item) { self.enterState(state: $0, viewController: mViewController) }
                return Observable.just(())
            }
    }

    func seminarButtonTapUseCase(viewController: UIViewController?,
                                 item: SeminarListResultDto.Item) -> Observable<Void> {
        return Observable.just(())
            .flatMapLatest { [weak self, weak viewController] in
                guard let mViewController = viewController else { return Observable<Void>.empty() }
                guard let self = self else { return Observable<Void>.empty() }
                self.accepNeedInformationToSeminar(title: item.title,
                                              videoStartTime: item.startAt,
                                              isSecret: item.isSecret,
                                              seminarID: item.id)
                self.entrance(item) { self.enterState(state: $0, viewController: mViewController) }
                return Observable.just(())
            }
    }

    func seminarButtonTapUseCase(viewController: UIViewController?,
                                 seminarId: Int,
                                 pageData: SeminarDetailResultDto) -> Observable<Void> {
        return Observable.just(())
            .flatMapLatest { [weak self, weak viewController] in
                guard let mViewController = viewController else { return Observable<Void>.empty() }
                guard let self = self else { return Observable<Void>.empty() }
                self.accepNeedInformationToSeminar(title: pageData.title,
                                              videoStartTime: pageData.startAt,
                                              isSecret: pageData.isSecret,
                                              seminarID: seminarId)
                self.entrance(seminarId, pageData) { self.enterState(state: $0, viewController: mViewController) }
                return Observable.just(())
            }
    }

    func presentEnterMetaverse(viewController: UIViewController?) -> Signal<Void> {
        guard let presentParticipate = seminarModel.presentParticipate else { return Signal<Void>.empty() }
        return presentParticipate
            .flatMapLatest { [weak self, weak viewController] in
                guard let self = self else { return Signal<Void>.empty() }
                let needInformationToSeminar = self.seminarModel.needInformationToSeminar.value
                let status = MetaWorldSceneStatus.seminar(roomID: $0.roomId,
                                                          unitySeminarID: $0.unitySeminarId,
                                                          seminarURL: $0.seminarUrl,
                                                          title: needInformationToSeminar.title,
                                                          videoStartTime: needInformationToSeminar.videoStartTime)
                let metaWorldViewModel = MetaWorldViewModel(metaworldSceneStatus: status)
                let metaWorldViewController = MetaWorldViewController(viewModel: metaWorldViewModel)

                viewController?.presentViewController(viewController: metaWorldViewController,
                                                      modalTransitionStyle: .crossDissolve,
                                                      modalPresentationStyle: .fullScreen)
                return Signal.just(())
            }
    }

    func presentMySeminar() -> Signal<Void> {
        guard let presentMySeminarParticipate = seminarModel.presentMySeminarParticipate else {
            return Signal<Void>.empty()
        }
        return presentMySeminarParticipate
            .flatMapLatest { [weak self] in
                guard let self = self else { return Signal<Void>.empty() }
                self.seminarModel.participate.accept($0)
                return Signal<Void>.just(())
            }
    }

    func presentApply() -> Signal<Void> {
        guard let presentApply = seminarModel.presentApply else { return Signal<Void>.empty() }
        return presentApply
            .flatMapLatest { [weak self] in
                guard let self = self else { return Signal<Void>.empty() }
                let needInformationToSeminar = self.seminarModel.needInformationToSeminar.value
                let isAPISuccess = $0
                let isSecret = self.seminarModel.needInformationToSeminar.value.isSecret
                if isAPISuccess && isSecret {
                    self.applyResultUpdate(needInformationToSeminar: needInformationToSeminar)
                    self.presentApplyModal(title: localizable.seminarManagerApplySucceedPrivate(),
                                           message: localizable.seminarManagerApplySucceedPrivateDesc())
                }
                if isAPISuccess && !isSecret {
                    self.applyResultUpdate(needInformationToSeminar: needInformationToSeminar)
                    self.presentApplyModal(title: localizable.seminarManagerApplySucceed(),
                                           message: localizable.seminarManagerApplySucceedDesc())
                }

                if !isAPISuccess {
                    self.presentAlertModal(message: localizable.seminarManagerApplyFailed())
                }
                return Signal.just(())
            }
    }
}
