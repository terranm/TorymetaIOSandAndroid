//
//  UnityTopIndicatorView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

typealias CampusTopIndicatorDto = (imgName: String, title: String)

final class CampusTopIndicatorView: UIView {

    let disposeBag = DisposeBag()

    let headerImgView = WilldUIImageView().then {
        $0.image = R.image.campusInfo_header()
    }

    let closeButton = WilldUIImageView.create(
        size: 44,
        assetsName: R.image.default_banner_exit.name,
        type: .plain
    ).then {
        $0.image = $0.image?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .togetherWhite
    }

    lazy var flowLayout = UICollectionViewFlowLayout().then {
        var ltPadding: CGFloat = 18
        let width: CGFloat = (UIScreen.main.bounds.width - ltPadding * 2) / 4
        let height: CGFloat = width * 16 / 21
        $0.itemSize = .init(width: width - 10, height: height)
    }

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .togetherPurple
        $0.register(CampusInficatorCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: CampusInficatorCollectionViewCell.self))
    }

    let items: Driver<[CampusTopIndicatorDto]> = Driver.just([
//        CampusTopIndicatorDto(imgName: "CampusInfo_toryTalk", title: localizable.campusToryTalk()),
        CampusTopIndicatorDto(imgName: "CampusInfo_we", title: localizable.campusOurParty()), // 0
        CampusTopIndicatorDto(imgName: "CampusInfo_food", title: localizable.campusTodayLunch()),
        CampusTopIndicatorDto(imgName: "CampusInfo_school_event", title: localizable.campusInnerEvent()),
//        CampusTopIndicatorDto(imgName: "CampusInfo_event", title: localizable.campusOuterEvent()),
//        CampusTopIndicatorDto(imgName: "CampusInfo_step", title: localizable.campusTraveler()),
        CampusTopIndicatorDto(imgName: "CampusInfo_select_school", title: localizable.campusSelectSchool())
    ])

    private var itemSelectedDelegate: (Int) -> Void = { _ in }

    var maxSize: CGFloat = 0.0
    var minSize: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribite()
        layout()
        bind()

        let safeAreaTop = WDHelper.getWindow()?.safeAreaInsets.top ?? 0.0
        let ltPadding: CGFloat = 18
        let width: CGFloat = (UIScreen.main.bounds.width - ltPadding * 2) / 4
        let height: CGFloat = width * 16 / 21

        self.maxSize = safeAreaTop + 20 + height * 1 + (24 + 16) + 15
        self.minSize = safeAreaTop + 28 + 20 + 15
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind() {
        items
            .drive(collectionView.rx.items) { [weak self] collectionView, row, data in
                guard let self = self else { return BaseCollectionViewCell() }
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier:
                                            String(describing: CampusInficatorCollectionViewCell.self),
                                         for: indexPath) as? CampusInficatorCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(data)

                cell.rx.baseTapGesture()
                    .bind(onNext: {
                        self.itemSelectedDelegate(row)
                    })
                    .disposed(by: cell.disposeBag)
                return cell

            }
            .disposed(by: disposeBag)
    }

    func setItemSelectedDelegate(_ delegate: @escaping (Int) -> Void) {
        self.itemSelectedDelegate = delegate
    }

    private func attribite() {
        backgroundColor = .togetherPurple
    }

    private func layout() {
        addSubviews(headerImgView, collectionView, closeButton)

        headerImgView.snp.makeConstraints {
            let safeAreaTop = WDHelper.getWindow()?.safeAreaInsets.top ?? 0.0
            $0.top.equalToSuperview().inset(safeAreaTop + 16)
            $0.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerImgView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(15)
        }

        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(headerImgView)
            $0.trailing.equalToSuperview()
        }
    }
}
