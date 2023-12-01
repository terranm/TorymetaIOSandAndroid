//
//  AvatarDecoViewModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/26.
//

import Foundation
import RxSwift
import RxRelay

final class AvatarDecoViewModel: RefactoringBaseViewModel {
    enum DecoEventType {
        case tab(category: DecoCategoryType)    // 카테고리 탭 선택
        case pallette(color: AvatarColor)       // 꾸미기 컬러 선택
        case itemList(item: AvatarModeling, willActive: Bool)     // 꾸미기 아이템 선택
        case rotate     // 아바타 회전
        case restore    // 아바타 초기화
        case save       // 아바타 저장
    }

    enum DecoCategoryType: String, CaseIterable {
        case hair, face, top, bottom, shoes

        var title: String {
            switch self {
            case .hair:     return localizable.decoHair()
            case .face:     return localizable.decoCoordi()
            case .top:      return localizable.decoTop()
            case .bottom:   return localizable.decoBottom()
            case .shoes:    return localizable.decoShoes()
            }
        }

        var colorType: String? {
            switch self {
            case .hair: return "hair"
            case .face: return "skin"
            default: return nil
            }
        }

        var index: Int {
            DecoCategoryType.allCases.firstIndex(of: self) ?? 0
        }
    }

    enum SortType: Int, CaseIterable {
        case defaults, famous, highPrice, lowPrice
        var title: String {
            switch self {
            case .defaults:     return localizable.decoSortDefault()
            case .famous:       return localizable.decoSortPopular()
            case .highPrice:   return localizable.decoSortHigherPrice()
            case .lowPrice:     return localizable.decoSortLowerPrice()
            }
        }
    }

    enum ListOptionType {
        case showSortingList
        case didSelectSortingList(sortType: SortType)
//        case didSelectToryFilter, didSelectMileageFilter
    }
    let repository = WDRepository.shared
    private let unity = UnityManager.shared
    private(set) var currentAvatarInfo: AvatarAttribute?
    private(set) lazy var mileageRelay = repository.point
    private(set) var decoEventRelay = PublishRelay<DecoEventType>()
    private(set) var currentCategoryType = DecoCategoryType.allCases.first ?? .face
    private(set) var colorsRelay = BehaviorRelay<[AvatarColor]>(value: [])
    private(set) var listOptionRelay = PublishRelay<ListOptionType>()
    private(set) var currentPurchaseStatus = PublishRelay<PurchaseStatus>()
    private(set) var needPurchaseItemsRelay = BehaviorRelay<[AvatarModeling]>(value: [])

    private(set) var avatarPreviewViewModel: AvatarPreviewViewModel

    init(_ avatarPreviewViewModel: AvatarPreviewViewModel) {
        self.avatarPreviewViewModel = avatarPreviewViewModel
        super.init()
        bind()
    }

    private func bind() {
        defer {
            didSelectRestore()
        }

        decoEventRelay
            .bind { [weak self] eventType in
                guard let self else { return }
                switch eventType {
                case let .tab(category):    // 카테고리 탭 선택
                    self.currentCategoryType = category
                case let .pallette(color):  // 꾸미기 컬러 선택
                    self.didSelectColor(color)
                case let .itemList(item, willActive):   // 꾸미기 아이템 선택
                    self.didSelectItem(item, willActive)
                    self.setNeedPurchaseItem(item, willActive)
                case .rotate:   // 아바타 회전
                    self.didSelectRotate()
                case .restore:  // 아바타 초기화
                    self.didSelectRestore()
                case .save:     // 아바타 저장
                    self.didSelectSave()
                }
            }
            .disposed(by: disposeBag)
    }

    // MARK: - 꾸미기 컬러 선택
    struct AvatarItem: Codable {
        let item: String
        let color: String
    }
    private func didSelectColor(_ color: AvatarColor) {
        guard var avatarInfo = currentAvatarInfo else { return }
        var avatarItem = AvatarItem(item: "", color: "")
        if case .face = currentCategoryType {
            avatarInfo.skinColorCode = color.colorCode
            avatarItem = AvatarItem(item: avatarInfo.skinCode, color: color.colorCode)
        } else if case .hair = currentCategoryType {
            avatarInfo.hairColorCode = color.colorCode
            avatarItem = AvatarItem(item: avatarInfo.hairCode, color: color.colorCode)
        }
        currentAvatarInfo = avatarInfo
        unity.callToUnityFunction(.selectAvatarItem, avatarItem)
    }

    // MARK: - 꾸미기 아이템 선택
    private func didSelectItem(_ item: AvatarModeling, _ willActive: Bool) {
        // 아이템 select 시 currentAvatarInfo에 선택한 아이템을 추가한다. deselect인 경우에는 이전 아이템으로 돌린다.
        guard var avatarInfo = currentAvatarInfo else { return }
        var avatarItem = AvatarItem(item: "", color: "")
        switch currentCategoryType {
        case .face:
            avatarInfo.faceCode = willActive ? item.modelingCode : repository.myAvatarAttr.value.faceCode
            avatarItem = AvatarItem(item: avatarInfo.faceCode, color: avatarInfo.skinColorCode)
        case .hair:
            avatarInfo.hairCode = willActive ? item.modelingCode : repository.myAvatarAttr.value.hairCode
            avatarItem = AvatarItem(item: avatarInfo.hairCode, color: avatarInfo.hairColorCode)
        case .top:
            avatarInfo.topCode = willActive ? item.modelingCode : repository.myAvatarAttr.value.topCode
            avatarItem = AvatarItem(item: avatarInfo.topCode, color: avatarInfo.topColorCode)
        case .bottom:
            avatarInfo.bottomCode = willActive ? item.modelingCode : repository.myAvatarAttr.value.bottomCode
            avatarItem = AvatarItem(item: avatarInfo.bottomCode, color: avatarInfo.bottomColorCode)
        case .shoes:
            avatarInfo.shoesCode = willActive ? item.modelingCode : repository.myAvatarAttr.value.shoesCode
            avatarItem = AvatarItem(item: avatarInfo.shoesCode, color: avatarInfo.shoesColorCode)
        }
        currentAvatarInfo = avatarInfo
        unity.callToUnityFunction(.selectAvatarItem, avatarItem)
    }

    // MARK: 구매 필요한 아이템 목록
    private func setNeedPurchaseItem(_ item: AvatarModeling, _ willActive: Bool) {
        guard !item.isOwned else { return } // 이미 소유한 아이템은 추가하지 않는다.
        var currentItems = needPurchaseItemsRelay.value
        let existItemIndex = currentItems.firstIndex(where: { $0.group == item.group }) ?? -1
        switch (existItemIndex >= 0, willActive) {
        case (false, true): // 구매할 아이템과 같은 그룹의 아이템이 배열에 존재안함, 아이템 select -> 추가
            currentItems.append(item)
            needPurchaseItemsRelay.accept(currentItems)
        case (true, true):  // 구매할 아이템과 같은 그룹의 아이템이 배열에 존재함, 아이템 select -> 치환
            currentItems[existItemIndex] = item
            needPurchaseItemsRelay.accept(currentItems)
        case (true, false): // 구매할 아이템과 같은 그룹의 아이템이 배열에 존재함, 아이템 deselect -> 제거
            currentItems.remove(at: existItemIndex)
            needPurchaseItemsRelay.accept(currentItems)
        default:
            break
        }
//        dump(needPurchaseItemsRelay.value)
    }

    // MARK: 구매 아이템들의 전체 가격
    var totalPriceInt: Int {
        needPurchaseItemsRelay.value.compactMap({ $0.price }).reduce(0, +)
    }
    var totalPrice: String {
        totalPriceInt.decimalPointed ?? ""
    }

    // MARK: - 아바타 회전
    private func didSelectRotate() {
        unity.callToUnityFunction(.rotateAvatar)
    }

    // MARK: - 아바타 초기화
    private func didSelectRestore() {
        let prevAvatarInfo = repository.myAvatarAttr.value
        currentAvatarInfo = prevAvatarInfo
        let avatarInfo = InitAvatarAttribute(userName: repository.member.value.name,
                                             memberId: repository.member.value.memberId,
                                             avatarState: prevAvatarInfo)
        unity.callToUnityFunction(.initAvatarItems, avatarInfo)
        needPurchaseItemsRelay.accept([])    // 구매 목록 초기화
    }

    // MARK: - 아바타 저장
    private func didSelectSave() {
        guard let currentAvatarInfo else { return }
        repository.saveAvatar(saveInfo: currentAvatarInfo)
            .bind { [weak self] succeed in
                guard let self, succeed else { return }
                self.repository.hasAvaterAttr.accept(true)
                self.repository.myAvatarAttr.accept(currentAvatarInfo)
                self.unity.callToUnityFunction(.selectAvatarItem, currentAvatarInfo)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - 결재
    enum PurchaseStatus {
        case available, insufficient
    }
    func didSelectPurchase() {
        let paymentAvailable = totalPriceInt <= mileageRelay.value.mileage
        switch paymentAvailable {
        case true:
            currentPurchaseStatus.accept(.available)
        case false:
            currentPurchaseStatus.accept(.insufficient)
        }
    }

    func didSelectPurcahseItem(_ completion: (Bool) -> Void) {
        // TODO: 구매 api 호출 후 결과 전달
        let isSucceessPurchaseItem = true
        completion(isSucceessPurchaseItem)
    }

    func didSelectPurchaseCoin(_ completion: (Bool) -> Void) {
        // TODO: 코인 결재 후 결과 전달
        let isSucceessPurchaseItem = true
        completion(isSucceessPurchaseItem)
    }
}
