//
//  ProfileChangeViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture
import UIKit

final class ProfileChangeViewModel: RefactoringBaseViewModel {
    let imagePickerType = PublishRelay<WillPickerTypeCase>()

    let profileChangeButtonTap = PublishRelay<UITapGestureRecognizer>()
    var presentProfileSelectCategoryAlert: Signal<UITapGestureRecognizer>! = nil
    var profileImage: Driver<URL?>! = nil
    let selectAlbumImage = PublishRelay<UIImage?>()

    override init() {
        super.init()

        profileImage = repository.member
            .filter {
                $0.memberId != 0
            }
            .map { URL(string: $0.imgUrl) }
            .asDriver(onErrorDriveWith: .empty())

        selectAlbumImage
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                return self.repository.uploadImage(image: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)

        presentProfileSelectCategoryAlert = profileChangeButtonTap
            .asSignal()
    }
}
