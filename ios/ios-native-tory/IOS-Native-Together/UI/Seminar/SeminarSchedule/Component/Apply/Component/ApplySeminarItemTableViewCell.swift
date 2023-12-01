//
//  CreateSeminarItemTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift

final class ApplySeminarItemTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    private let backView = WilldUIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
    }

    private let tagLabel = WilldUILabel.create(font: .regular10, text: "-", color: .togetherWhite)
    private lazy var tagView = WilldUIView().then {
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

    private let lockImgView = WilldUIImageView.create(size: 34, assetsName: R.image.seminar_lock.name, type: .plain)
    private let profileImgView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.layer.cornerRadius = 8
    }

    private let cntImgView = WilldUIImageView.create(size: 24,
                                                     assetsName: R.image.seminar_people_cnt.name,
                                                     type: .plain)
    private let cntLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherWhite)
    private lazy var thumbnailImgView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        /*
         UI 배치
         */
        $0.addSubviews(tagView, lockImgView, profileImgView, cntImgView, cntLabel)

        tagView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
        }

        lockImgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(9)
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

    private let titleLabel = WilldUILabel.create(
        font: .bold20,
        text: "-",
        color: .togetherBlack
    ).then {
        $0.numberOfLines = 1
    }

    private let descriptionLabel = WilldUILabel.create(
        font: .regular14,
        text: "-",
        color: .togetherGray1
    ).then {
        $0.numberOfLines = 1
    }

    private let dateLabel = WilldUILabel.create(
        font: .regular12,
        text: "-",
        color: .togetherGray2
    ).then {
        $0.numberOfLines = 0
    }

    private let lockInfoImgView = WilldUIImageView.create(
        size: 24,
        assetsName: R.image.seminar_lock_info_clip.name,
        type: .plain
    )

    private let lockInfoLabel = WilldUILabel.create(
        font: .regular12,
        text: localizable.applySeminarItemPasswordDesc(),
        color: .togetherGray2
    )

    lazy var lockInfoBackView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.backgroundColor = UIColor("#F8F8FA")
        $0.layer.cornerRadius = 2
        /*
         UI 배치
         */
        $0.addSubviews(lockInfoLabel, lockInfoImgView)

        lockInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }

        lockInfoImgView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }

    lazy var detailInfoButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = .togetherGray2
        $0.layer.cornerRadius = 16
        /*
         UI 배치
         */
        $0.addSubview(detailInfoButtonLabel)
        detailInfoButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let detailInfoButtonLabel = WilldUILabel.create(font: .bold14,
                                                            text: localizable.applySeminarItemShowDetail(),
                                                            color: .togetherWhite)

    lazy var participateButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 16
        /*
         UI 배치
         */
        $0.addSubview(participateButtonLabel)
        participateButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let participateButtonLabel = WilldUILabel.create(font: .bold14,
                                                             text: localizable.applySeminarItemEntrance(),
                                                             color: .togetherWhite)

    private lazy var stackView = UIStackView(arrangedSubviews: [detailInfoButton, participateButton]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 16
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

    func configure(_ data: SeminarListResultDto.Item, _ seminarManager: SeminarManager) {
        seminarManager.setTagUI(data: data) { [weak self] in
            guard let self = self else { return }
            self.tagLabel.text = $0.tagStr
            self.tagView.backgroundColor = UIColor($0.tagColorStr)
            self.cntLabel.text = $0.countInfoString
        }

        thumbnailImgView.kf.setImage(with: URL(string: data.room.roomImageUrl))

        profileImgView.kf.setImage(with: URL(string: data.teacherImageUrl))

        lockImgView.isHidden = !data.isSecret
        lockInfoBackView.isHidden = true
        lockInfoLabel.text = data.password.isEmpty ? localizable.applySeminarItemEntranceDesc(): "\(data.password)"

        titleLabel.text = data.title

        descriptionLabel.text = data.description
        dateLabel.text = data.dateStr

        seminarManager.setEntranceButtonUI(data: data) { [weak self] in
            guard let self = self else { return }
            self.participateButtonLabel.text = $0.buttonTitle
            self.participateButton.backgroundColor = $0.buttonBackgroundColor
        }
    }

    func layout() {
        contentView.addSubviews(backView, thumbnailImgView,
                                titleLabel, descriptionLabel, dateLabel,
                                lockInfoBackView, stackView)

        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(stackView).inset(-20)
            $0.leading.trailing.equalToSuperview()
        }

        thumbnailImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImgView.snp.bottom).offset(20)
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
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(lockInfoBackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
}
