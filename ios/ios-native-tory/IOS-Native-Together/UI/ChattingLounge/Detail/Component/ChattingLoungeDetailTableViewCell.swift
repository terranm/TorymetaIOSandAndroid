//
//  ChattingLoungeDetailTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeDetailTableViewCell: BaseTableViewCell {

    private var disposeBag = DisposeBag()
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let nickNameLabel = UILabel()
    private let participateIconImageView = UIImageView()
    private let participageCountLabel = UILabel()
    private let secretIconImageView = UIImageView()
    private let entranceeButton = UIView()
    private let entranceButtonLabel = UILabel()
    private let underlineView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func bind(data: ChattingLoungeChattingRoomList.Item, _ viewModel: ChattingLoungeDetailViewModel) {
        entranceeButton.rx.baseTapGesture()
            .filter { !data.isRoomLock }
            .map { data }
            .bind(to: viewModel.entranceButtonTap)
            .disposed(by: disposeBag)
    }

    func setUI(_ data: ChattingLoungeChattingRoomList.Item, isLast: Bool) {
        thumbnailImageView.kf.setImage(with: URL(string: data.imageURL),
                                       placeholder: R.image.chatLounge_placeholder())

        titleLabel.text = data.title
        nickNameLabel.text = data.creatorName

        participageCountLabel.text = "\(data.clients)/\(data.maxClients)"

        secretIconImageView.isHidden = !data.isSecret

        entranceeButton.backgroundColor = !data.isRoomLock ? .togetherPurple : .togetherGray3
        underlineView.isHidden = isLast
    }

    private func attribute() {
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.contentMode = .scaleAspectFill

        titleLabel.configureFont(.bold14)
        titleLabel.numberOfLines = 2

        nickNameLabel.configureFont(.regular12)
        nickNameLabel.textColor = .togetherPurple

        participateIconImageView.image = R.image.newMain_people_participate_cnt()
        participateIconImageView.image = participateIconImageView.image?.withRenderingMode(.alwaysTemplate)
        participateIconImageView.tintColor = UIColor("#666666")

        participageCountLabel.configureFont(.regular12)
        participageCountLabel.textColor = UIColor("#9E9E9E")

        secretIconImageView.image = R.image.chatting_lounge_detail_secret()

        entranceeButton.layer.cornerRadius = 8
        entranceeButton.backgroundColor = .togetherPurple

        entranceButtonLabel.text = localizable.chattingLoungeDetailEntrance()
        entranceButtonLabel.configureFont(.regular12)
        entranceButtonLabel.textColor = .togetherWhite

        underlineView.backgroundColor = .togetherGray3
    }

    private func layout() {
        contentView.addSubviews(thumbnailImageView, titleLabel, nickNameLabel,
                                participateIconImageView, participageCountLabel, secretIconImageView,
                                entranceeButton, entranceButtonLabel, underlineView)

        thumbnailImageView.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualTo(entranceeButton.snp.leading).offset(-8)
        }
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(titleLabel)
        }
        participateIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(nickNameLabel)
            $0.leading.equalTo(nickNameLabel.snp.trailing).offset(8)
        }
        participageCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(nickNameLabel)
            $0.leading.equalTo(participateIconImageView.snp.trailing).offset(2)
        }
        secretIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(nickNameLabel)
            $0.leading.equalTo(participageCountLabel.snp.trailing).offset(12)
        }
        entranceeButton.snp.makeConstraints {
            $0.width.equalTo(44)
            $0.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        entranceButtonLabel.snp.makeConstraints {
            $0.center.equalTo(entranceeButton)
        }
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
