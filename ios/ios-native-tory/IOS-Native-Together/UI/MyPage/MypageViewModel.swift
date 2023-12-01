//
//  MypageViewModel.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/26.
//

import Foundation
import RxCocoa
import RxSwift
import RxGesture
import Kingfisher

final class MypageViewModel: RefactoringBaseViewModel {
    var universityStr: Driver<String>?

    let noticeButtonTap = PublishRelay<UITapGestureRecognizer>()
    let settingButtonTap = PublishRelay<UITapGestureRecognizer>()

    var profileImageURL: Driver<URL?>?

    var nickName: Driver<String>?

    let mileageButtonTap = PublishRelay<Void>()
    var mileagePoint: Driver<String>?
    var presentMileageDetailPage: Signal<Void>?

    let toryPointButtonTap = PublishRelay<Void>()
    var toryPoint: Driver<Int>?
    var presentToryPointDetailPage: Signal<Void>?

    let chargingButtonTap = PublishRelay<UITapGestureRecognizer>()
    var presentUserToryPointChargePage: Signal<Void>?

    override init() {
        super.init()

        let pageData = repository.member
            .filter { $0.memberId != 0 }
            .asDriver(onErrorDriveWith: .empty())

        universityStr = repository
            .getMyCampus()
            .map { [weak self] in
                guard let self = self else { return "" }
                if !self.repository.member.value.isUniversityConfirm {
                    return localizable.myPageUnivUnauthorized()
                } else {
                    return $0.universityName
                }
            }
            .asDriver(onErrorDriveWith: .empty())

        profileImageURL = pageData
            .map {
                $0.imgUrl
            }
            .map {
                URL(string: $0)
            }

        nickName = pageData
            .map {
                $0.profileName
            }

        mileagePoint = repository.point
            .map {
                WDHelper.numberToNumberSeparator($0.mileage) + " M"
            }
            .asDriver(onErrorDriveWith: .empty())

        toryPoint = repository.point
            .map {
                $0.point
            }
            .asDriver(onErrorDriveWith: .empty())

        presentMileageDetailPage = mileageButtonTap
            .map { _ in
                ()
            }
            .asSignal(onErrorSignalWith: .empty())

        presentToryPointDetailPage = toryPointButtonTap
            .map { _ in
                ()
            }
            .asSignal(onErrorSignalWith: .empty())

        presentUserToryPointChargePage = chargingButtonTap
            .map { _ in
                ()
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
