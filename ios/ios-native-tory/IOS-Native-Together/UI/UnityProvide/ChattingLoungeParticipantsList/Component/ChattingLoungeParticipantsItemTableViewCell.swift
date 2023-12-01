//
//  ChattingLoungeParticipantsItemTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeParticipantsItemTableViewCell: BaseTableViewCell {
    private var disposeBag = DisposeBag()

    private let profileImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let ownerLabel = UILabel()
    private let underLineView = UIView()

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

    func bind(_ data: FromUnityParticipantsInformation.Item, _ viewModel: ChattingLoungeParticipantsListViewModel) {
        contentView.rx.baseTapGesture()
            .map { data.status }
            .filter {
                switch $0 {
                case .exist: return false
                case .request: return true
                }
            }
            .bind(to: viewModel.requestButtonTap)
            .disposed(by: disposeBag)
    }

    func setUI(data: FromUnityParticipantsInformation.Item, isLast: Bool) {
        print("🧊 isLast \(isLast)")
        underLineView.isHidden = isLast
        switch data.status {
        case .exist:
            profileImageView.kf.setImage(with: URL(string: data.imgUrl))

            ownerLabel.isHidden = !data.isOwner
            ownerLabel.text = data.isOwner ? "\(localizable.chattingLoungeParticipantsOwnerDecoText()) " : ""

            nickNameLabel.text = data.profileName
            nickNameLabel.configureFont(data.isOwner ? .bold14 : .regular14)
            nickNameLabel.textColor = data.isOwner ? .togetherPurple : .togetherBlack
        case .request:
            profileImageView.image = R.image.chatting_lounge_participants_friend_request()

            ownerLabel.isHidden = true
            ownerLabel.text = ""

            nickNameLabel.text = localizable.chattingLoungeParticipantsInvite()
            nickNameLabel.configureFont(.regular14)
            nickNameLabel.textColor = .togetherPurple
        }
    }

    private func attribute() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 16

        ownerLabel.text = "\(localizable.chattingLoungeParticipantsOwnerDecoText()) "
        ownerLabel.configureFont(.bold14)
        ownerLabel.textColor = .togetherPurple

        underLineView.backgroundColor = .togetherGray3
    }

    private func layout() {
        contentView.addSubviews(profileImageView, ownerLabel, nickNameLabel, underLineView)
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(1)
        }

        ownerLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }

        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(ownerLabel.snp.trailing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
