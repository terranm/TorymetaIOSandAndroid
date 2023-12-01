//
//  BoardSelectViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/10.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa

final class BoardSelectViewController: RefactoringBaseViewController<BoardSelectViewModel>,
                                       RefactoringBasePanModalPresentable {
    var shortFormHeight: PanModalHeight { .maxHeightWithTopInset(0) }
    var longFormHeight: PanModalHeight { .maxHeightWithTopInset(0) }
    private let backgroundView = UIImageView()
    private let containerView = UIView()
    private let uniImgView = UIImageView()
    private let titleLabel = UILabel()
    private let underLineView = UIView()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var selectCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let closeButton = UIImageView()

    private var delegate: (String) -> Void = { _ in }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func attribute() {
        super.attribute()

        backgroundView.backgroundColor = .clear

        containerView.backgroundColor = .togetherWhite
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = UIColor.togetherPurple.cgColor
        containerView.layer.cornerRadius = 16

        titleLabel.font = R.font.notoSansSemiBold(size: 20)
        titleLabel.text = localizable.campusOurParty()
        titleLabel.textColor = .togetherBlack

        underLineView.backgroundColor = .togetherGray2

        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 22

        let ltPadding: CGFloat = 40
        let width: CGFloat = (270 - ltPadding * 2) / 2
        let height: CGFloat = 104
        flowLayout.itemSize = CGSize(width: width - 22, height: height)

        selectCollectionView.backgroundColor = .togetherWhite
        selectCollectionView.register(NewBoardSelectCollectionViewCell.self,
                                      forCellWithReuseIdentifier: NewBoardSelectCollectionViewCell.identifier)

        closeButton.image = R.image.board_close()
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView,
                         containerView,
                         uniImgView,
                         titleLabel,
                         underLineView,
                         selectCollectionView,
                         closeButton)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 270, height: 410))
            $0.center.equalToSuperview()
        }
        uniImgView.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.equalTo(containerView)
            $0.centerX.equalTo(backgroundView)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(uniImgView.snp.bottom).offset(6)
            $0.centerX.equalTo(containerView)
        }
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(containerView).inset(35)
        }
        selectCollectionView.snp.makeConstraints {
            $0.top.equalTo(underLineView).offset(18)
            $0.leading.trailing.equalTo(containerView).inset(40)
            $0.bottom.equalTo(containerView).inset(3)
        }
        closeButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.centerX.equalTo(containerView)
            $0.bottom.equalTo(containerView).offset(-16)
        }
    }

    override func bind(_ viewModel: BoardSelectViewModel) {
        Observable
            .merge(backgroundView.rx.tapGesture().when(.recognized), closeButton.rx.tapGesture().when(.recognized))
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.getCampusImageURL()
            .drive(uniImgView.rx.imageURLString)
            .disposed(by: disposeBag)

        viewModel.getBoardList()
            .drive(selectCollectionView.rx.items) { [weak self] collectionView, row, data in
                guard let self = self else { return UICollectionViewCell() }
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: NewBoardSelectCollectionViewCell.identifier,
                                         for: indexPath) as? NewBoardSelectCollectionViewCell else {
                    return UICollectionViewCell()
                }

                cell.configre(data)
                cell.rx.baseTapGesture()
                    .bind(onNext: { [weak self] in
                        guard let self = self else { return }
                        self.dismiss(animated: true)
                        self.delegate(data.webViewUrl)
                    })
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension BoardSelectViewController {
    func setDelegate(delegate: @escaping (String) -> Void) {
        self.delegate = delegate
    }
}
