//
//  DecoCollectionView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/27.
//

import UIKit
import RxSwift
import RxDataSources

// MARK: - Section type
struct DecoItemSection {
    var items: [AvatarModeling]
}
extension DecoItemSection: SectionModelType {
    typealias Item = AvatarModeling
    init(original: DecoItemSection, items: [AvatarModeling]) {
        self = original
        self.items = items
    }
}

final class DecoCollectionView: UICollectionView {

    typealias ListOptionType = AvatarDecoViewModel.ListOptionType
    typealias DecoEventType = AvatarDecoViewModel.DecoEventType
    private let disposeBag = DisposeBag()
    private(set) var viewModel: DecoCollectionViewModel
    private var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let contentWidth = UIScreen.main.bounds.width - (16 * 2) // 컬렉션 좌우 인셋이 16씩 존재
        layout.itemSize = CGSize(width: contentWidth / 4, height: (contentWidth / 4) + 24)
        return layout
    }()

    init(_ frame: CGRect = .zero,
         _ collectionViewLayout: UICollectionViewLayout? = nil,
         viewModel: DecoCollectionViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, collectionViewLayout: flowLayout)
        attribute()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        register(DecoCollectionViewCell.self, forCellWithReuseIdentifier: DecoCollectionViewCell.identifier)
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: safeAreaInsets.bottom + 20, right: 16)
    }

    private func bind() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<DecoItemSection>(
            configureCell: { _, collectionView, indexPath, item in // dataSource, _, _, _
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: DecoCollectionViewCell.identifier,
                                         for: indexPath) as? DecoCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.currentItemRelay.accept(item)
                return cell
        })
        viewModel.itemsRelay
            .bind(to: self.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        rx.itemSelected
            .bind { [weak self] indexPath in
                self?.didSelectedItem(indexPath)
            }
            .disposed(by: disposeBag)

        rx.itemDeselected
            .bind { [weak self] indexPath in
                self?.didDeselectedItem(indexPath)
            }
            .disposed(by: disposeBag)

        viewModel.avatarDecoViewModel.listOptionRelay
            .bind { [weak self] listOptionType in
                self?.didSelectSortingOption(listOptionType)
            }
            .disposed(by: disposeBag)

        rx.willDisplayCell
            .bind { [weak self] cell, indexPath in
                self?.configureCell(cell, indexPath)
            }
            .disposed(by: disposeBag)

        viewModel.avatarDecoViewModel.decoEventRelay
            .bind { [weak self] decoEventType in
                self?.didSelectRestore(decoEventType)
            }
            .disposed(by: disposeBag)
    }

    private func didSelectedItem(_ indexPath: IndexPath) {
        guard let cell = cellForItem(at: indexPath) as? DecoCollectionViewCell else { return }
        if cell.isActivated && viewModel.isDefaultItem {    // 활성된 아이템을 선택하였고 초기에 장착한 아이템이다.
            return
        } else if cell.isActivated && !viewModel.isDefaultItem { // 활성된 아이템을 선택하였고 초기에 장착한 아이템이 아이템이 아니다.
            restoreToDefaultItem() // 초기에 장착한 아이템이 활성화 된다.
        }

        cell.isActivated = !cell.isActivated
        viewModel.didSelectItem(indexPath, cell.isActivated)
    }

    private func restoreToDefaultItem() {
        let indexPath = viewModel.indexOfDefaultItem
        guard indexPath.item >= 0, let cell = cellForItem(at: indexPath) as? DecoCollectionViewCell else { return }
        cell.isActivated = true
        selectItem(at: indexPath, animated: false, scrollPosition: .init())
    }

    private func didDeselectedItem(_ indexPath: IndexPath) {
        guard let cell = cellForItem(at: indexPath) as? DecoCollectionViewCell else { return }
        cell.isActivated = false
        viewModel.didSelectItem(indexPath, false)
    }

    private func didSelectSortingOption(_ listOptionType: ListOptionType) {
        guard case .didSelectSortingList = listOptionType else { return }
        UIView.performWithoutAnimation { [weak self] in
            self?.reloadSections([0])
        }
    }

    private func configureCell(_ cell: UICollectionViewCell, _ indexPath: IndexPath) {
        guard let currentCell = cell as? DecoCollectionViewCell else { return }
        let isActivated = viewModel.isPreviouslyActivatedItem(indexPath)
        if isActivated {
            selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            deselectItem(at: indexPath, animated: false)
        }
        currentCell.isActivated = isActivated
    }

    private func didSelectRestore(_ decoEventType: DecoEventType) {
        guard case .restore = decoEventType else { return }
        reloadData()
    }
}
