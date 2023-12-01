//
//  CampusSelectBottomDetailViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa

final class CampusPlayViewController: RefactoringBaseViewController<CampusPlayViewModel>,
                                      RefactoringBasePanModalPresentable {
    var shortFormHeight: PanModalHeight { .contentHeight(508) }
    var longFormHeight: PanModalHeight { .contentHeight(508) }
    private let headerLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

    private var delegate: ((UniversityListResultDto.Item) -> Void) = { _ in }

    override func attribute() {
        super.attribute()

        headerLabel.font = R.font.notoSansSemiBold(size: 20)
        headerLabel.text = localizable.campusPlayTitle()
        headerLabel.textColor = .togetherBlack

        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 5
        let width = (view.frame.width - 32) / 3
        let height = 20 * width / 27
        flowLayout.itemSize = .init(width: width - 5, height: height)

        collectionView.backgroundColor = .togetherWhite
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 256, right: 0)
        collectionView.register(CampusPlayCollectionViewCell.self,
                    forCellWithReuseIdentifier: CampusPlayCollectionViewCell.identifier)
    }

    override func layout() {
        super.layout()

        view.addSubviews(headerLabel, collectionView)

        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: CampusPlayViewModel) {
        super.bind(viewModel)

        viewModel.getCampusList()
            .filter { !$0.isEmpty }
            .bind(to: collectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CampusPlayCollectionViewCell.identifier,
                    for: indexPath) as? CampusPlayCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(data: data)
                cell.rx.tapGesture()
                    .when(.recognized)
                    .map { _ in
                        var items = viewModel.list.value
                        for index in items.indices {
                            items[index].isSelect = false
                        }
                        items[indexPath.row].isSelect = true
                        return items
                    }
                    .bind(to: viewModel.list)
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.getSelectItem()
            .emit(onNext: { [weak self] data in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    self.delegate(data)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CampusPlayViewController {
    func setDelegate(delegate: @escaping (UniversityListResultDto.Item) -> Void) {
        self.delegate = delegate
    }
}
