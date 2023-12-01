//
//  WilldImagePickerViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/03.
//

import UIKit
import RxSwift
import RxCocoa

final class WilldImagePickerViewModel: RefactoringBaseViewModel {
    let type: WillPickerTypeCase
    let imageItems = BehaviorRelay<[URL?]>(value: [])
    var presentImageItems: Driver<[URL?]>! = nil
    var selectAlbumImage: PublishRelay<UIImage?>! = nil

    /*
     isPaging
     */
    let paging = PublishRelay<Bool>()

    let pageSize = 10
    let currentPage = BehaviorRelay<Int>(value: 0)
    let isLastPage = BehaviorRelay<Bool>(value: false)

    init(_ type: WillPickerTypeCase, _ selectAlbumImage: PublishRelay<UIImage?>) {
        self.type = type
        super.init()
        switch type {
        case.simple:
            repository.defaultImgUrlList.asObservable().map {
                $0.map {
                    URL(string: $0)
                }
            }
            .bind(to: imageItems)
            .disposed(by: disposeBag)
        case.nft:
            repository.getNFTList(currentPage: self.currentPage.value, perPage: self.pageSize).map {
                $0.map { URL(string: $0.imageURL) }
            }
            .bind(to: imageItems)
            .disposed(by: disposeBag)
        }

        self.selectAlbumImage = selectAlbumImage

        presentImageItems = imageItems
            .asDriver(onErrorDriveWith: .empty())

        paging
            .filter { _ in
                type == .nft
            }
            .filter {
                $0
            }
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return !self.isLastPage.value
            }
            .flatMap { [weak self] _ -> Observable<Int> in
                guard let self = self else { return Observable<Int>.empty() }
                var currentPage = self.currentPage.value
                currentPage += 1
                self.currentPage.accept(currentPage)
                return Observable.just(currentPage)
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[OwnerNftResultDto]>.empty() }
                return repository.getNFTList(currentPage: $0, perPage: self.pageSize)
            }
            .map {
                $0.map {
                    URL(string: $0.imageURL)
                }
            }
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if $0.count < self.pageSize {
                    self.isLastPage.accept(true)
                }

                var items = self.imageItems.value
                if !$0.isEmpty {
                    items += $0
                    self.imageItems.accept(items)
                }
            })
            .disposed(by: disposeBag)
    }
}
