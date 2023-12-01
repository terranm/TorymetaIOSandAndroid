//
//  LiveSeminarCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/30.
//

import UIKit
import RxSwift

final class LiveSeminarCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    let sumbnailImgView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 140).isActive = true
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private let tagBackView = WilldUIView().then {
        $0.backgroundColor = UIColor("#FD6E6E")
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.layer.cornerRadius = 4
    }

    private let tagLabel = WilldUILabel.create(font: .regular10,
                                               text: localizable.seminarInProgress(),
                                               color: .togetherWhite)
    private let tagMyLabel = UILabel().then {
        $0.text = "MY"
        $0.textColor = .white
        $0.configureFont(.regular10)
        $0.backgroundColor = UIColor("#103771")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
        $0.textAlignment = .center
        $0.isHidden = true
    }

    private let profileImgView = WilldUIImageView().then {
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private let peopleCntImgView = WilldUIImageView.create(size: 16,
                                                           assetsName: R.image.newMain_people_participate_cnt.name,
                                                           type: .plain)
    private let peopleCntLabel = WilldUILabel.create(font: .bold12, text: "-", color: .togetherWhite)
    private let decorateImgView = WilldUIImageView.create(size: 24, assetsName: "", type: .plain)
    private let titleLabel = WilldUILabel.create(font: .regular16, text: "-",
                                                 color: .togetherBlack, numberOfLines: 1)
    private let descriptionLabel = WilldUILabel.create(font: .regular12, text: "-",
                                                       color: .togetherGray2, numberOfLines: 2)
    private let scheduleLabel = WilldUILabel.create(font: .regular10, text: "-", color: .togetherGray2)

    let participateButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 68).isActive = true
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 8
    }

    private let participateLabel = WilldUILabel.create(font: .regular14,
                                                       text: localizable.joinSeminar(),
                                                       color: .togetherWhite)
    private let lockImgView = WilldUIImageView.create(size: 34, assetsName: R.image.seminar_lock.name, type: .plain)

    override var intrinsicContentSize: CGSize {
        let thumbnailSize: CGFloat = 140
        let participateButtonSize: CGFloat = 68
        let descriptionSize = descriptionLabel.intrinsicContentSize
        let scheduleSize = scheduleLabel.intrinsicContentSize
        let width = UIScreen.main.bounds.width
        let height = thumbnailSize + 12 + participateButtonSize + 8
        + descriptionSize.height + 4 + scheduleSize.height
        return CGSize(width: width, height: height)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(_ data: LiveSeminarListResultDto.Item, _ seminarManager: SeminarManager) {
        seminarManager.setTagUI(data: data) { [weak self] in
            guard let self = self else { return }
            self.tagLabel.text = $0.tagStr
            self.tagBackView.backgroundColor = UIColor($0.tagColorStr)
            self.peopleCntLabel.text = $0.countInfoString
        }

        sumbnailImgView.kf.setImage(with: URL(string: data.roomImageUrl))
        lockImgView.isHidden = !data.isSecret
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        scheduleLabel.text = data.dateStr

        seminarManager.setEntranceButtonUI(data: data) { [weak self] in
            guard let self = self else { return }

            self.profileImgView.isHidden = $0.isProfileHidden
            if !$0.profileImgURL.isEmpty {
                self.profileImgView.kf.setImage(with: URL(string: $0.profileImgURL))
            }
            self.participateLabel.text = $0.buttonTitle
            self.participateButton.backgroundColor = $0.buttonBackgroundColor
        }

        tagMyLabel.isHidden = repository.member.value.memberId != data.teacherId
    }

    private func layout() {
        contentView.addSubviews(sumbnailImgView, tagBackView, tagLabel, tagMyLabel, profileImgView, peopleCntImgView,
                                peopleCntLabel, decorateImgView, titleLabel, descriptionLabel, scheduleLabel,
                                participateButton, participateLabel, lockImgView)

        sumbnailImgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        tagBackView.snp.makeConstraints {
            $0.top.leading.equalTo(sumbnailImgView).inset(8)
        }
        tagLabel.snp.makeConstraints {
            $0.center.equalTo(tagBackView)
        }

        tagMyLabel.snp.makeConstraints {
            $0.centerY.equalTo(tagBackView.snp.centerY)
            $0.left.equalTo(tagBackView.snp.right).offset(6)
            $0.size.equalTo(CGSize(width: 40, height: 20))
        }

        profileImgView.snp.makeConstraints {
            $0.leading.bottom.equalTo(sumbnailImgView).inset(8)
        }

        peopleCntLabel.snp.makeConstraints {
            $0.bottom.equalTo(sumbnailImgView).inset(8)
            $0.trailing.equalTo(sumbnailImgView).inset(12)
        }

        peopleCntImgView.snp.makeConstraints {
            $0.trailing.equalTo(peopleCntLabel.snp.leading)
            $0.centerY.equalTo(peopleCntLabel)
        }

        decorateImgView.snp.makeConstraints {
            $0.top.trailing.equalTo(sumbnailImgView).inset(8)
        }

        participateButton.snp.makeConstraints {
            $0.top.equalTo(sumbnailImgView.snp.bottom).offset(12)
            $0.trailing.equalTo(sumbnailImgView)
        }

        participateLabel.snp.makeConstraints {
            $0.center.equalTo(participateButton)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(participateButton)
            $0.leading.equalTo(sumbnailImgView)
            $0.trailing.equalTo(participateButton.snp.leading).offset(-8)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(participateButton.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-8)
        }

        scheduleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }

        lockImgView.snp.makeConstraints {
            $0.top.trailing.equalTo(sumbnailImgView).inset(6)
        }
    }
}
