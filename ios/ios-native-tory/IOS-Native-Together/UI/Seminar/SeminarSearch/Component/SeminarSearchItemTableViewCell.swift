//
//  SeminarSearchItemTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/09.
//

import UIKit
import RxSwift
import RxCocoa

final class SeminarSearchItemTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
    }

    let tagLabel = WilldUILabel.create(font: .bold10, text: "-", color: .togetherWhite)

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

    let myTagLabel = WilldUILabel.create(font: .bold10, text: "MY", color: .togetherWhite)

    lazy var myTagView = WilldUIView().then {
        $0.backgroundColor = UIColor("#103771")
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        $0.layer.cornerRadius = 4
        /*
         UI 배치
         */
        $0.addSubview(myTagLabel)
        myTagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    let lockImgView = WilldUIImageView.create(size: 34, assetsName: R.image.seminar_lock.name, type: .plain)

    let profileImgView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.layer.cornerRadius = 8
    }

    let cntImgView = WilldUIImageView.create(size: 24, assetsName: R.image.seminar_people_cnt.name, type: .plain)
    let cntLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherWhite)

    lazy var thumbnailImgView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        /*
         UI 배치
         */
        $0.addSubviews(tagView, myTagView, lockImgView, profileImgView, cntImgView, cntLabel)
        tagView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
        }

        myTagView.snp.makeConstraints {
            $0.centerY.equalTo(tagView)
            $0.leading.equalTo(tagView.snp.trailing).offset(8)
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

    let titleLabel = WilldUILabel.create(font: .bold20, text: "-", color: .togetherBlack).then {
        $0.numberOfLines = 1
    }

    let descriptionLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherGray1).then {
        $0.numberOfLines = 1
    }

    let dateLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherGray2).then {
        $0.numberOfLines = 0
    }

    let participateButtonLabel = WilldUILabel.create(font: .regular14,
                                                     text: localizable.seminarSearchJoin(),
                                                     color: .togetherWhite)

    lazy var participateButton = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 68).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 8
        $0.addSubview(participateButtonLabel)
        participateButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
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

        titleLabel.text = data.title

        descriptionLabel.text = data.description
        dateLabel.text = data.dateStr

        seminarManager.setEntranceButtonUI(data: data) { [weak self] in
            guard let self = self else { return }

            self.myTagView.isHidden = $0.isMyTagHidden
            self.participateButtonLabel.text = $0.buttonTitle
            self.participateButton.backgroundColor = $0.buttonBackgroundColor
        }
    }

    func layout() {
        contentView.addSubviews(backView, thumbnailImgView, titleLabel, descriptionLabel, dateLabel, participateButton)

        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(dateLabel).inset(-20)
            $0.leading.trailing.equalToSuperview()
        }

        thumbnailImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImgView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(participateButton.snp.leading).offset(-16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(40)
        }

        participateButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.centerY.equalTo(titleLabel)
        }
    }
}
