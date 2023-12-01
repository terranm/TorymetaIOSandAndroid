//
//  DecoCollectionViewModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/31.
//

import Foundation
import RxSwift
import RxRelay

final class DecoCollectionViewModel: RefactoringBaseViewModel {

    typealias DecoCategoryType = AvatarDecoViewModel.DecoCategoryType
    typealias ListOptionType = AvatarDecoViewModel.ListOptionType

    private let repository = WDRepository.shared
    private(set) var currentCategory: DecoCategoryType
    private(set) var avatarDecoViewModel: AvatarDecoViewModel
    private(set) var itemsRelay = BehaviorRelay<[DecoItemSection]>(value: [])
    private(set) var avatarColors = [AvatarColor]()

    init(_ categoryType: DecoCategoryType, _ avatarDecoViewModel: AvatarDecoViewModel) {
        self.currentCategory = categoryType
        self.avatarDecoViewModel = avatarDecoViewModel
        super.init()
        bind()
    }

    private func bind() {
        repository
            .getAvatarItemList(category: currentCategory.rawValue)
            .map { [DecoItemSection(items: $0)] }
            .bind(to: itemsRelay)
            .disposed(by: disposeBag)

        if let colorType = currentCategory.colorType {
            repository
                .getAvatarColorList(category: colorType)
                .subscribe { [weak self] colors in
                    guard let self else { return }
                    self.avatarColors = colors
                    // 첫번째 탭의 ViewModel로 생성되는 경우 첫번째 탭의 팔레트가 지정되도록 colorsRelay를 accept한다.
                    if self.currentCategory == DecoCategoryType.allCases.first {
                        self.avatarDecoViewModel.colorsRelay.accept(colors)
                    }
                }
                .disposed(by: disposeBag)
        }

        avatarDecoViewModel
            .listOptionRelay
            .subscribe { [weak self] listOptionType in
                self?.didSelectSortingList(listOptionType)
            }
            .disposed(by: disposeBag)
    }

    private func didSelectSortingList(_ listOptionType: ListOptionType) {
        guard case let .didSelectSortingList(sortType) = listOptionType else { return }
        var sorted: [AvatarModeling]?
        switch sortType {
        case .defaults:
            sorted = itemsRelay.value.first?.items.sorted(by: {$0.id < $1.id})
        case .famous:
            sorted = itemsRelay.value.first?.items.sorted(by: {$0.payCount < $1.payCount})
        case .highPrice:
            sorted = itemsRelay.value.first?.items.sorted(by: {$0.price > $1.price})
        case .lowPrice:
            sorted = itemsRelay.value.first?.items.sorted(by: {$0.price < $1.price})
        }

        guard let sorted else { return }
        itemsRelay.accept([DecoItemSection(items: sorted)])
    }

    func didSelectItem(_ indexPath: IndexPath, _ willActive: Bool) {
        guard let selectedItem = itemsRelay.value[safe: indexPath.section]?.items[safe: indexPath.item] else { return }
        avatarDecoViewModel.decoEventRelay.accept(.itemList(item: selectedItem, willActive: willActive))
    }

    func isPreviouslyActivatedItem(_ indexPath: IndexPath) -> Bool {
        var currentCode: String?
        switch currentCategory {
        case .hair:
            currentCode = avatarDecoViewModel.currentAvatarInfo?.hairCode
        case .face:
            currentCode = avatarDecoViewModel.currentAvatarInfo?.faceCode
        case .top:
            currentCode = avatarDecoViewModel.currentAvatarInfo?.topCode
        case .bottom:
            currentCode = avatarDecoViewModel.currentAvatarInfo?.bottomCode
        case .shoes:
            currentCode = avatarDecoViewModel.currentAvatarInfo?.shoesCode
        }
        return itemsRelay.value[safe: indexPath.section]?.items[safe: indexPath.item]?.modelingCode == currentCode
    }

    var isDefaultItem: Bool {
        switch currentCategory {
        case .hair:
            return repository.myAvatarAttr.value.hairCode == avatarDecoViewModel.currentAvatarInfo?.hairCode
        case .face:
            return repository.myAvatarAttr.value.faceCode == avatarDecoViewModel.currentAvatarInfo?.faceCode
        case .top:
            return repository.myAvatarAttr.value.topCode == avatarDecoViewModel.currentAvatarInfo?.topCode
        case .bottom:
            return repository.myAvatarAttr.value.bottomCode == avatarDecoViewModel.currentAvatarInfo?.bottomCode
        case .shoes:
            return repository.myAvatarAttr.value.shoesCode == avatarDecoViewModel.currentAvatarInfo?.shoesCode
        }
    }

    var indexOfDefaultItem: IndexPath {
        switch currentCategory {
        case .hair:
            let index = itemsRelay.value.first?.items
                .firstIndex(where: { repository.myAvatarAttr.value.hairCode == $0.modelingCode }) ?? -1
            return IndexPath(item: index, section: 0)
        case .face:
            let index = itemsRelay.value.first?.items
                .firstIndex(where: { repository.myAvatarAttr.value.faceCode == $0.modelingCode }) ?? -1
            return IndexPath(item: index, section: 0)
        case .top:
            let index = itemsRelay.value.first?.items
                .firstIndex(where: { repository.myAvatarAttr.value.topCode == $0.modelingCode }) ?? -1
            return IndexPath(item: index, section: 0)
        case .bottom:
            let index = itemsRelay.value.first?.items
                .firstIndex(where: { repository.myAvatarAttr.value.bottomCode == $0.modelingCode }) ?? -1
            return IndexPath(item: index, section: 0)
        case .shoes:
            let index = itemsRelay.value.first?.items
                .firstIndex(where: { repository.myAvatarAttr.value.shoesCode == $0.modelingCode }) ?? -1
            return IndexPath(item: index, section: 0)
        }
    }
}
