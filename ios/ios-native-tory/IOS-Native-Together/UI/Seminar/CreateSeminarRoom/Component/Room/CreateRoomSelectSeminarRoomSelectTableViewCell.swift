//
//  CreateRoomSelectSeminarRoomSelectTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa

// swiftlint:disable type_body_length
final class CreateRoomSelectSeminarRoomSelectTableViewCell: BaseTableViewCell {
    var disposeBag = DisposeBag()

    let backView = WilldUIView()

    private let titleLabel = WilldUILabel.create(
        font: .bold14,
        text: localizable.seminarRoomSelect(),
        color: .togetherBlack
    )

    private let titleDecorateLabel = WilldUILabel.create(
        font: .regular12,
        text: localizable.seminarRoomSelectRequired(),
        color: .togetherRed
    )

    private let allButtonLabel = WilldUILabel.create(
        font: .regular14,
        text: localizable.seminarRoomSelectAll(),
        color: .togetherBlack
    )

    lazy var allButton = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 44).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true

        $0.addSubview(allButtonLabel)
        allButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let line1 = WilldUIView().then {
        $0.backgroundColor = .togetherGray3
        $0.widthAnchor.constraint(equalToConstant: 1).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private let smallButtonLabel = WilldUILabel.create(
        font: .regular14,
        text: localizable.seminarRoomSmall(),
        color: .togetherBlack
    )

    private let smallButtonDecoLabel = WilldUILabel.create(
        font: .regular12,
        text: localizable.seminarRoomAdmit18(),
        color: .togetherGray2
    )

    lazy var smallButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
        $0.addSubview(smallButtonLabel)
        $0.addSubview(smallButtonDecoLabel)
        smallButtonLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(11)
        }
        smallButtonDecoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(smallButtonLabel.snp.trailing).offset(2)
        }
    }

    private let line2 = WilldUIView().then {
        $0.backgroundColor = .togetherGray3
        $0.widthAnchor.constraint(equalToConstant: 1).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private let middleButtonLabel = WilldUILabel.create(
        font: .regular14,
        text: localizable.seminarRoomMiddle(),
        color: .togetherBlack
    )

    private let middleButtonDecoLabel = WilldUILabel.create(
        font: .regular12,
        text: localizable.seminarRoomAdmit32(),
        color: .togetherGray2
    )

    lazy var middleButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
        $0.addSubview(middleButtonLabel)
        $0.addSubview(middleButtonDecoLabel)
        middleButtonLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(11)
        }
        middleButtonDecoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(middleButtonLabel.snp.trailing).offset(2)
        }
    }

    private let line3 = WilldUIView().then {
        $0.backgroundColor = .togetherGray3
        $0.widthAnchor.constraint(equalToConstant: 1).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private let bigButtonLabel = WilldUILabel.create(
        font: .regular14,
        text: localizable.seminarRoomLarge(),
        color: .togetherBlack).then {
        $0.textAlignment = .right
    }

    private let bigButtonDecoLabel = WilldUILabel.create(
        font: .regular12,
        text: localizable.seminarRoomAdmit50(),
        color: .togetherGray2
    ).then {
        $0.textAlignment = .left
    }

    lazy var bigButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
        $0.addSubview(bigButtonLabel)
        $0.addSubview(bigButtonDecoLabel)
        bigButtonLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(11)
        }
        bigButtonDecoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(bigButtonLabel.snp.trailing).offset(2)
        }
    }

    /*
     collectionView Item...
     */

    var seminarList: [SeminarRoomTypeListResultDto.Item] = []

    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0

        $0.scrollDirection = .horizontal

        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 240

        $0.itemSize = .init(width: width - 32, height: height)
    }

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.register(CreateRoomSelectSeminarItemCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: CreateRoomSelectSeminarItemCollectionViewCell.self))
        $0.heightAnchor.constraint(equalToConstant: 240).isActive = true
        $0.isPagingEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }

    let pageControl = UIPageControl().then {
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .togetherWhite
        $0.currentPageIndicatorTintColor = .togetherPurple
    }

    /*
     이전 세미나
     오른쪽, 왼쪽 가기 버튼
     */
//    let leftButton = WilldUIImageView.create(
//        size: 44,
//        assetsName: "Seminar_create_page_left",
//        type: .plain
//    )
//    let rightButton = WilldUIImageView.create(
//        size: 44,
//        assetsName: "Seminar_create_page_right",
//        type: .plain
//    )

    private let underLineView = WilldUIView().then {
        $0.backgroundColor = .togetherGray3
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    private let cntInfoLabel = WilldUILabel.create(
        font: .regular16,
        text: localizable.seminarRoomCount(),
        color: UIColor("#37424D")
    )

    let cntDownButton = WilldUIImageView.create(
        size: 32,
        assetsName: R.image.seminar_create_cnt_down.name,
        type: .plain
    )
    let cntUpButton = WilldUIImageView.create(
        size: 32,
        assetsName: R.image.seminar_create_cnt_up.name,
        type: .plain
    )

    let cntLabel = WilldUILabel.create(
        font: .regular16,
        text: "0",
        color: UIColor("#37424D")
    )

    private lazy var cntBackView = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 88).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor("#E6E6E6").cgColor
        $0.addSubviews(cntLabel)
        cntLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let peopleCntInfoLabel = WilldUILabel.create(
        font: .regular16,
        text: localizable.seminarRoomAvailableAdmitDesc(),
        color: .togetherGray2
    )

    private let peopleCntLabel = WilldUILabel.create(
        font: .regular16,
        text: "",
        color: .togetherGray2
    )

    private lazy var peopleCntBackView = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 88).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = UIColor("#F8F8FA")
        $0.layer.cornerRadius = 4
        $0.addSubviews(peopleCntLabel)
        peopleCntLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let allPeopleCntInfoLabel = WilldUILabel.create(
        font: .regular16,
        text: localizable.seminarRoomAvailableTotalAdmit(),
        color: .togetherGray2
    )

    private let allPeopleCntLabel = WilldUILabel.create(
        font: .regular16,
        text: "",
        color: .togetherGray2
    )

    private lazy var allPeopleBackView = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 88).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = UIColor("#F8F8FA")
        $0.layer.cornerRadius = 4
        $0.addSubviews(allPeopleCntLabel)
        allPeopleCntLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let underLine2 = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        $0.backgroundColor = .togetherGray3
    }

    private let warningInfoLabel = WilldUILabel.create(
        font: .regular12,
        text: localizable.seminarRoomAvailableTotalAdmitDesc(),
        color: .togetherRed
    )

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func getPeopleCnt() -> Int {
        let result = Int(peopleCntLabel.text ?? "0") ?? 0
        return result
    }

    func getAllCnt() -> Int {
        let result = Int(allPeopleCntLabel.text ?? "0") ?? 0
        return result
    }

    func configure(isCreate: Bool, tag: Int, list: [SeminarRoomTypeListResultDto.Item], seminarCtn: Int) {

        createSetUI(isCreate: isCreate)

        pageControl.numberOfPages = list.count
        pageControl.isHidden = list.count <= 1

        cntLabel.text = "\(seminarCtn)"

        /*
         버튼 탭
         */
        initTap()
        switch tag {
        case 0:
            presentTap(btn: allButtonLabel)
        case 1:
            presentTap(btn: smallButtonLabel)
        case 2:
            presentTap(btn: middleButtonLabel)
        case 3:
            presentTap(btn: bigButtonLabel)
        default:
            break
        }

        /*
         세미나 리스트
         */
        self.seminarList = list
        self.collectionView.reloadData()

        let item = list.filter {
            $0.isSelect
        }

        if !item.isEmpty {
            peopleCntLabel.text = "\(item[0].maxParticipation)"
            let allCnt = seminarCtn * item[0].maxParticipation
            if allCnt >= 200 {
                allPeopleCntLabel.text = "200"
            } else {
                allPeopleCntLabel.text = "\(allCnt)"
            }

        } else {
            peopleCntLabel.text    = "0"
            allPeopleCntLabel.text = "0"
        }
    }

    private func createSetUI(isCreate: Bool) {
        [underLineView,
         cntInfoLabel, cntBackView, cntDownButton, cntUpButton,
         peopleCntInfoLabel, peopleCntBackView,
         allPeopleCntInfoLabel, allPeopleBackView,
         underLine2, warningInfoLabel].forEach {
            $0.isHidden = !isCreate
        }
    }

    private func presentTap(btn: UILabel) {
        btn.textColor = .togetherPurple
        btn.configureFont(.bold14)
    }

    private func clearTap(btn: UILabel) {
        btn.textColor = .togetherBlack
        btn.configureFont(.regular14)
    }

    private func initTap() {
        [allButtonLabel, smallButtonLabel, middleButtonLabel, bigButtonLabel].forEach {
            clearTap(btn: $0)
        }
    }

    func register(delegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
    }

    private func layout() {
        contentView.addSubviews(backView, titleLabel, titleDecorateLabel, allButton,
                                line1, smallButton, line2, middleButton, line3, bigButton,
                                collectionView, pageControl, underLineView,
                                cntInfoLabel, cntBackView, cntDownButton, cntUpButton,
                                peopleCntInfoLabel, peopleCntBackView,
                                allPeopleCntInfoLabel, allPeopleBackView,
                                underLine2, warningInfoLabel)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        titleDecorateLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
        }

        allButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(-10)
        }

        line1.snp.makeConstraints {
            $0.centerY.equalTo(allButton)
            $0.leading.equalTo(allButton.snp.trailing)
        }

        smallButton.snp.makeConstraints {
            $0.centerY.equalTo(allButton)
            $0.leading.equalTo(line1.snp.trailing)
        }

        line2.snp.makeConstraints {
            $0.centerY.equalTo(allButton)
            $0.leading.equalTo(smallButton.snp.trailing)
        }

        middleButton.snp.makeConstraints {
            $0.centerY.equalTo(allButton)
            $0.leading.equalTo(line2.snp.trailing)
        }

        line3.snp.makeConstraints {
            $0.centerY.equalTo(allButton)
            $0.leading.equalTo(middleButton.snp.trailing)
        }

        bigButton.snp.makeConstraints {
            $0.centerY.equalTo(allButton)
            $0.leading.equalTo(line3.snp.trailing)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(allButton.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
        }

        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(collectionView)
            $0.bottom.equalTo(collectionView).inset(46)
        }

//        leftButton.snp.makeConstraints {
//            $0.top.equalTo(collectionView).inset(80)
//            $0.leading.equalToSuperview().inset(10)
//        }
//
//        rightButton.snp.makeConstraints {
//            $0.top.equalTo(collectionView).inset(80)
//            $0.trailing.equalToSuperview().inset(10)
//        }

        underLineView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }

        cntInfoLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(27)
            $0.leading.equalToSuperview()
        }

        cntBackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(42)
            $0.centerY.equalTo(cntInfoLabel)
        }

        cntDownButton.snp.makeConstraints {
            $0.centerY.equalTo(cntBackView)
            $0.trailing.equalTo(cntBackView.snp.leading).offset(-10)
        }

        cntUpButton.snp.makeConstraints {
            $0.centerY.equalTo(cntBackView)
            $0.leading.equalTo(cntBackView.snp.trailing).offset(10)
        }

        peopleCntInfoLabel.snp.makeConstraints {
            $0.top.equalTo(cntInfoLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview()
        }

        peopleCntBackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(42)
            $0.centerY.equalTo(peopleCntInfoLabel)
        }

        allPeopleCntInfoLabel.snp.makeConstraints {
            $0.top.equalTo(peopleCntInfoLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview()
        }

        allPeopleBackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(42)
            $0.centerY.equalTo(allPeopleCntInfoLabel)
        }

        underLine2.snp.makeConstraints {
            $0.top.equalTo(allPeopleCntInfoLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }

        warningInfoLabel.snp.makeConstraints {
            $0.top.equalTo(underLine2.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(88)
        }
    }
}
