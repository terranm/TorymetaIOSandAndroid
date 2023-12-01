//
//  AvatarSelectViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/08.
//

// swiftlint:disable all
import Foundation
import RxSwift
import RxCocoa

struct AvatarSelectViewModel : BaseViewModelProtocal {

    let completeButtonTap = PublishRelay<Void>()
    var presentComplete : Signal<Bool>! = nil

    let zoomInButtonTap = PublishRelay<Void>()
    var presentZoomInButtonTap : Signal<Void>! = nil

    let zoomOutButtonTap = PublishRelay<Void>()
    var presentZoomOutButtonTap : Signal<Void>! = nil

    let rotationButtonTap = PublishRelay<Void>()
    var presentRotaionButtonTap : Signal<Void>! = nil

    let avatarList = BehaviorRelay<[AvatarListResultDto.Item]>(value: [])
    var presentAvatartList : Driver<[AvatarListResultDto.Item]>! = nil

    init() {

        presentComplete = completeButtonTap
            .map { [self] in
                avatarList.value.filter {
                    $0.isSelect
                }
            }
            .filter {
                !$0.isEmpty
            }
            .map {
                $0[0]
            }
            .flatMap { [self] in
                repository.updateAvatar(id: $0.id)
            }
            .asSignal(onErrorSignalWith: .empty())

        presentZoomInButtonTap = zoomInButtonTap
            .map { _ in
                ()
            }
            .asSignal(onErrorSignalWith: .empty())

        presentZoomOutButtonTap = zoomOutButtonTap
            .map { _ in
                ()
            }
            .asSignal(onErrorSignalWith: .empty())

        presentRotaionButtonTap = rotationButtonTap
            .map { _ in
                ()
            }
            .asSignal(onErrorSignalWith: .empty())

        presentAvatartList = avatarList
            .asDriver(onErrorDriveWith: .empty())

    }

}
