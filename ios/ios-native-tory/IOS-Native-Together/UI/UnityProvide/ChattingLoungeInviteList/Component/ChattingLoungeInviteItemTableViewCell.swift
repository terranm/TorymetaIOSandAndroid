//
//  ChattingLoungeInviteItemTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/18.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeInviteItemTableViewCell: BaseTableViewCell {
    private var disposeBag = DisposeBag()
    private let profileImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let inviteButton = UIImageView()
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

    func bind(_ data: FriendInfo, _ viewModel: ChattingLoungeInviteListViewModel) {
        inviteButton.rx.baseTapGesture()
            .map { data }
            .bind(to: viewModel.inviteButtonTap)
            .disposed(by: disposeBag)
    }

    func setUI(_ data: FriendInfo, isLast: Bool) {
        profileImageView.kf.setImage(with: URL(string: data.imgUrl))
        nickNameLabel.text = data.profileName
        underLineView.isHidden = isLast
    }

    private func attribute() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 16

        nickNameLabel.configureFont(.regular14)

        inviteButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        inviteButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        inviteButton.image = R.image.chatting_lounge_invite_friend_request()
    }

    private func layout() {
        contentView.addSubviews(profileImageView, nickNameLabel, inviteButton)
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualTo(inviteButton.snp.trailing).offset(8)
        }

        inviteButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview()
        }
    }
}
