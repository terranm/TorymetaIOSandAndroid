//
//  SeminarMainSeminarItemCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa

final class SeminarMainSeminarItemCollectionViewCell: UICollectionViewCell {

    var disposeBag = DisposeBag()
    private let tagLabel = WilldUILabel.create(font: .regular10, text: "-", color: .togetherWhite)

    private lazy var tagView = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.layer.cornerRadius = 4
        /*
         UI 배치
         */
        $0.addSubview(tagLabel)
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

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

    private let lockImgView = WilldUIImageView.create(
        size: 24,
        assetsName: R.image.seminar_lock.name,
        type: .plain
    )

    private let profileImgView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 4
    }

    private let cntImgView = WilldUIImageView.create(size: 24,
                                                     assetsName: R.image.seminar_people_cnt.name,
                                                     type: .plain)
    private let cntLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherWhite)

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    lazy var thumbnailImgView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 104).isActive = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        /*
         UI 배치
         */
        $0.addSubviews(tagView, tagMyLabel, lockImgView, profileImgView, cntImgView, cntLabel)
        tagView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(6)
        }

        tagMyLabel.snp.makeConstraints {
            $0.centerY.equalTo(tagView.snp.centerY)
            $0.left.equalTo(tagView.snp.right).offset(6)
            $0.size.equalTo(CGSize(width: 40, height: 20))
        }

        lockImgView.snp.makeConstraints {
            $0.centerY.equalTo(tagView)
            $0.trailing.equalToSuperview()
        }

        profileImgView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(6)
        }

        cntLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview().inset(6)
        }

        cntImgView.snp.makeConstraints {
            $0.centerY.equalTo(cntLabel)
            $0.trailing.equalTo(cntLabel.snp.leading)
        }
    }

    private let titleLabel = WilldUILabel.create(font: .bold16, text: "-", color: .togetherBlack, numberOfLines: 1)
    private let descriptionLabel = WilldUILabel.create(font: .regular12,
                                                       text: "-",
                                                       color: .togetherGray2,
                                                       numberOfLines: 1)
    private let dateLabel = WilldUILabel.create(font: .regular10, text: "-", color: .togetherGray2, numberOfLines: 1)
    private let participateButtonLabel = WilldUILabel.create(font: .regular14, text: "참여하기", color: .togetherWhite)

    lazy var participateButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .togetherPurple

        $0.addSubviews(participateButtonLabel)
        participateButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override var intrinsicContentSize: CGSize {
        let thumnailSize: CGFloat = 104
        let titleSize = titleLabel.intrinsicContentSize
        let descriptionSize = descriptionLabel.intrinsicContentSize
        let dateSize = dateLabel.intrinsicContentSize
        let participateButtonSize: CGFloat = 32

        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = thumnailSize + 10 + titleSize.height + 2
            + descriptionSize.height + 2 + dateSize.height + 14 + participateButtonSize
        return CGSize(width: width, height: height)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // swiftlint:disable cyclomatic_complexity
    func configure(_ data: LiveSeminarListResultDto.Item, _ seminarManager: SeminarManager) {
        seminarManager.setTagUI(data: data) { [weak self] in
            guard let self = self else { return }
            self.tagLabel.text = $0.tagStr
            self.tagView.backgroundColor = UIColor($0.tagColorStr)
            self.cntLabel.text = $0.countInfoString
        }

        thumbnailImgView.kf.setImage(with: URL(string: data.roomImageUrl))

        lockImgView.isHidden = !data.isSecret

        titleLabel.text = data.title
        descriptionLabel.text = data.description
        dateLabel.text = data.dateStr

        /*
         layout 배치
         */
        if data.description.isEmpty {
            descriptionLabel.isHidden = true
            dateLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(6)
                $0.leading.trailing.equalToSuperview()
            }
            participateButton.snp.makeConstraints {
                $0.top.equalTo(dateLabel.snp.bottom).offset(29)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        }

        seminarManager.setEntranceButtonUI(data: data) { [weak self] in
            guard let self = self else { return }

            self.profileImgView.isHidden = $0.isProfileHidden
            if !$0.profileImgURL.isEmpty {
                self.profileImgView.kf.setImage(with: URL(string: $0.profileImgURL))
            }
            self.participateButtonLabel.text = $0.buttonTitle
            self.participateButton.backgroundColor = $0.buttonBackgroundColor

        }

        tagMyLabel.isHidden = repository.member.value.memberId != data.teacherId
    }

    private func layout() {
        addSubviews(thumbnailImgView, titleLabel, descriptionLabel, dateLabel, participateButton)
        thumbnailImgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImgView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
        }
        participateButton.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
