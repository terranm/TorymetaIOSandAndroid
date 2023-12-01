//
//  UnityProvideTestViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/16.
//

import UIKit
import RxSwift
import RxCocoa

final class UnityProvideTestViewController: UIViewController {

    let disposeBag = DisposeBag()
    let button = WilldUILabel.create(font: .bold20, text: "모달 띄우기", color: .black)

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        AppConfigure.lockOrientation(.landscape)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind() {
        button.rx.baseTapGesture()
            .map {
//                "REPORT"
//                "CHATTING_LIST"
//                "USER_INTERACTION"
                "PARTICIPANTS"
//                "PASSWORD"
//                "CHAT_CREATE"
//                "INVTE"
            }
            .bind { [weak self] in
                switch $0 {
                case "REPORT":
                    let viewModel = ChattingLoungeReportViewModel(reportState: .reportRoom(0),
                                                                  isBackgrounClorClear: false)
                    let viewController = ChattingLoungeReportViewController(viewModel: viewModel)
                    self?.presentViewController(viewController: viewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                case "CHATTING_LIST":
                    let viewModel = ChattingLoungeChattingListViewModel()
                    let viewController = ChattingLoungeChattingListViewController(viewModel: viewModel)
                    self?.presentViewController(viewController: viewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                case "USER_INTERACTION":
                    let viewModel = ChattingLoungeUserInteractionListViewModel(isHostAthority: true, memberId: 0)
                    let viewController = ChattingLoungeUserInteractionListViewController(viewModel: viewModel)
                    self?.presentViewController(viewController: viewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                case "PARTICIPANTS":
                    let imageURL = "https://cdn.britannica.com/35/238335-050-2CB2EB8A/"
                        + "Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg"
                    let list = [FromUnityParticipantsInformation.Item(memberId: 1,
                                                                      profileName: "qwfqwf",
                                                                      phoneNum: "",
                                                                      imgUrl: imageURL,
                                                                      roomMaker: true)]
                    let data = FromUnityParticipantsInformation(roomId: "2", tableId: "",
                                                                maxClient: 2, chatRoomId: 0, list: list)
                    let viewModel = ChattingLoungeParticipantsListViewModel(participantsInfo: data)
                    let viewController = ChattingLoungeParticipantsListViewController(viewModel: viewModel)
                    self?.presentViewController(viewController: viewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                case "PASSWORD":
                    let viewModel =  ChattingLoungePasswordViewModel(password: "555555", isBackgroundClear: false)
                    let viewController = ChattingLoungePasswordViewController(viewModel: viewModel)
                    self?.presentViewController(viewController: viewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                case "CHAT_CREATE":
                    let viewModel = ChattingLoungeChattingEntranceViewModel()
                    let viewController = ChattingLoungeChattingEntranceViewController(viewModel: viewModel)
                    self?.presentViewController(viewController: viewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                case "INVTE":
                    break
//                    let list = [FromUnityInviteList
//                        .Item(memberId: 1, profileName: "", phoneNum: "", imgUrl: "", roomMaker: false)]
//                    let chattingLoungeInviteListViewModel
//                    = ChattingLoungeInviteListViewModel(inviteList: list)
//                    let chattingLoungeInviteListViewController
//                    = ChattingLoungeInviteListViewController(viewModel: chattingLoungeInviteListViewModel,
//                                                             isBackgroundColorClear: false)
//                    self?.presentViewController(vc: chattingLoungeInviteListViewController,
//                                                modalTransitionStyle: .crossDissolve,
//                                                modalPresentationStyle: .overFullScreen,
//                                                backgroundColor: .clear)
                default: return
                }
            }
            .disposed(by: disposeBag)
    }

    func layout() {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
