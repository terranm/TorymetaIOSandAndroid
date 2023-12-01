//
//  CreateSeminarItemTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateSeminarItemTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherPurple.cgColor
    }

    let titleLabel = WilldUILabel.create(
        font: .bold20,
        text: "-",
        color: .togetherBlack
    ).then {
        $0.numberOfLines = 1
    }

    let descriptionLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherGray1).then {
        $0.numberOfLines = 1
    }

    let dateLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherGray2).then {
        $0.numberOfLines = 0
    }

//    let lockInfoImgView = WilldUIImageView.create(
//        size: 24,
//        assetsName: "Seminar_lock_info_clip",
//        type: .plain
//    )

    let lockInfoLabel = WilldUILabel.create(font: .regular12,
                                            text: localizable.applySeminarItemPasswordDesc(),
                                            color: .togetherGray2)

    lazy var lockInfoBackView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.backgroundColor = UIColor("#F8F8FA")
        $0.layer.cornerRadius = 2
        /*
         UI 배치
         */
//        $0.addSubview(lockInfoImgView)
        $0.addSubview(lockInfoLabel)
//        lockInfoImgView.snp.makeConstraints {
//            $0.leading.equalToSuperview().inset(8)
//            $0.centerY.equalToSuperview()
//        }

        lockInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }

    let infoButtonLabel = WilldUILabel.create(font: .bold14,
                                              text: localizable.createSeminarItemModifyInfo(),
                                              color: .togetherWhite)

    lazy var infoButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = .togetherGray2
        $0.layer.cornerRadius = 16
        /*
         UI 배치
         */
        $0.addSubview(infoButtonLabel)
        infoButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    let enterButtonLabel = WilldUILabel.create(font: .bold14,
                                               text: localizable.createSeminarItemEntrance(),
                                               color: .togetherWhite)

    lazy var enterButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 16
        /*
         UI 배치
         */
        $0.addSubview(enterButtonLabel)
        enterButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    lazy var stackView = UIStackView(arrangedSubviews: [infoButton, enterButton])
        .then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 16
        }

    let tagLabel = WilldUILabel.create(font: .regular10, text: "-", color: .togetherWhite)

    lazy var tagView = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        $0.layer.cornerRadius = 4
        /*
         UI 배치
         */
        $0.addSubview(tagLabel)
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    let lockImgView = WilldUIImageView.create(size: 34, assetsName: R.image.seminar_lock.name, type: .plain)

    let deleteButton = WilldUIImageView.create(size: 34, assetsName: R.image.seminar_delete.name, type: .plain)

    let profileImgView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.layer.cornerRadius = 8
    }

    let cntImgView = WilldUIImageView.create(size: 24, assetsName: R.image.seminar_people_cnt.name, type: .plain)

    let cntLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherWhite)

    lazy var thumbnailImgView = WilldUIImageView().then {
        $0.layer.zPosition = -1
        $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        /*
         UI 배치
         */
        $0.addSubview(tagView)

        $0.addSubview(profileImgView)

        $0.addSubview(cntImgView)

        $0.addSubview(cntLabel)

        tagView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
        }

        profileImgView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(14)
        }

        cntLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(8)
        }

        cntImgView.snp.makeConstraints {
            $0.centerY.equalTo(cntLabel)
            $0.trailing.equalTo(cntLabel.snp.leading)
        }
    }

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

    func configure(_ data: SeminarListResultDto.Item) {
        let seminarManager = SeminarManager()
        seminarManager.setTagUI(data: data) { [weak self] in
            guard let self = self else { return }
            self.tagLabel.text = $0.tagStr
            self.tagView.backgroundColor = UIColor($0.tagColorStr)
            self.cntLabel.text = $0.countInfoString
        }

        thumbnailImgView.kf.setImage(with: URL(string: data.room.roomImageUrl))

        lockImgView.isHidden = !data.isSecret
        lockInfoBackView.isHidden = !data.isSecret
        lockInfoLabel.text = data.password.isEmpty ? localizable.applySeminarItemPasswordDesc(): "\(data.password)"

        titleLabel.text = data.title

        descriptionLabel.text = data.description
        dateLabel.text = data.dateStr

        profileImgView.kf.setImage(with: URL(string: data.teacherImageUrl))

        let now = Date()
        enterButtonLabel.text = localizable.createSeminarItemEntrance()
        if !now.isBeforeDate(data.endDate ?? Date(), granularity: .second) {
            /*
             종료
             */
            enterButton.backgroundColor = UIColor.togetherGray3
        } else {
            /*
             시작 전, 진행중
             */
            enterButton.backgroundColor = UIColor.togetherPurple
        }
    }

    func layout() {
        contentView.addSubviews(backView, titleLabel, descriptionLabel, dateLabel, dateLabel, lockInfoBackView,
                                stackView, thumbnailImgView, deleteButton, lockImgView)

        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(thumbnailImgView)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }

        lockInfoBackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(16)

        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(lockInfoBackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        thumbnailImgView.snp.makeConstraints {
            $0.top.equalTo(infoButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }

        deleteButton.snp.makeConstraints {
            $0.top.trailing.equalTo(thumbnailImgView).inset(6)
        }

        lockImgView.snp.makeConstraints {
            $0.centerY.equalTo(deleteButton)
            $0.trailing.equalTo(deleteButton.snp.leading)
        }
    }
}
