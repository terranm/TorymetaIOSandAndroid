//
//  MyStateViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/27.
//

import UIKit
import RxSwift
import RxCocoa

final class MyStateViewModel: RefactoringBaseViewModel {
    let locationButtonTap = PublishRelay<Void>()

    func profileImage() -> Driver<URL?> {
        repository.member
            .map { URL(string: $0.imgUrl) }
            .asDriver(onErrorDriveWith: .empty())
    }

    func universityName() -> Driver<String> {
        repository.getMyCampus()
            .map { $0.universityName }
            .asDriver(onErrorDriveWith: .empty())
    }

    func nickName() -> Driver<String> {
        repository.member
            .map { $0.profileName }
            .asDriver(onErrorDriveWith: .empty())
    }

    func locationImage() -> Driver<String> {
        repository.member
            .map { $0.isLocationExpose ? R.image.campus_location_on.name : R.image.campus_location_off.name }
            .asDriver(onErrorDriveWith: .empty())
    }

    func locationButtonTapWithToast() -> Signal<String> {
        locationButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<MyMemberResultDto>.empty() }
                return self.repository.updateMyLocationInformation()
            }
            .map {
                $0.isLocationExpose
                ? localizable.myStateLocationOpenMessage()
                : localizable.myStateLocationSecretMessage()
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
