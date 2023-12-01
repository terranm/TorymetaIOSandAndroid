//
//  FriendInfoTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/31.
//

import UIKit
import RxSwift
import RxCocoa

final class FriendInfoTableViewCell: BaseTableViewCell {

    private var disposeBag = DisposeBag()

    enum UIState {
        case new(_ data: FriendInfo, _ isHidden: Bool = true)
        case request(_ data: FriendInfo, _ isHidden: Bool = true)
        case block(_ data: BlockFriendInfo, _ isHidden: Bool = true)
        case range(_ data: RangeFriendInfo, _ isHidden: Bool = true)
        case marketing(_ data: FriendInfo, _ isHidden: Bool = true)
    }

    private let profileImageView = WilldUIImageView.create(size: 44, type: .cirecle)
    private let nameLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherBlack)
    private let buttonLabel = WilldUILabel.create(font: .regular16, text: "", color: .clear)

    private let underLineView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        $0.backgroundColor = .togetherGray3
    }

    private lazy var button = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.layer.cornerRadius = 16

        $0.addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    var uiState: UIState? {
        didSet {
            switch uiState {
            case .new(let data, let isHidden):
                setNewFriendUI(data: data, isHidden: isHidden)
            case .request(let data, let isHidden):
                setRequestUI(data: data, isHidden: isHidden)
            case .block(let data, let isHidden):
                setBlockUI(data: data, isHidden: isHidden)
            case .range(let data, let isHidden):
                setRangeUI(data: data, isHidden: isHidden)
            case .marketing(let data, let isHidden):
                setMarketingUI(data: data, isHidden: isHidden)
            default:
                break
            }
        }
    }

    var friendInteractionModel: FriendCommonViewModel? {
        didSet {
            guard let parentViewModel = friendInteractionModel else { return }
            bind(parentViewModel)
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

    private func bind(_ viewModel: FriendCommonViewModel) {
        button.rx.baseTapGesture()
            .map { [weak self] _ -> UpdateFriendStateInteractionCase? in
                guard let self = self else { return nil }
                switch self.uiState {
                case .new(let data, _):
                    return data.isInvite ? .friendUnAccept(data) : .friendAccept(data)
                case .request(let data, _):
                    return .friendRequest(data)
                case .block(let data, _):
                    return .friendUnBlock(data)
                case .marketing(let data, _):
                    return .friendMarketing(data)
                default: return nil
                }
            }
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case .friendAccept, .friendUnAccept, .friendRequest:
                    viewModel.friendInteractionButtonTap.accept($0)
                case .friendUnBlock(let data):
                    self.showInteractionInformationModal(title: localizable.friendInfoUnblock(),
                                                         message: localizable.friendInfoUnblockDesc(data.profileName),
                                                         completeButtonName: localizable.friendInfoUnlockConfirm()) {
                        let state = UpdateFriendStateInteractionCase.friendUnBlock(data)
                        viewModel.friendInteractionButtonTap.accept(state)
                    }
                case .friendMarketing(let data):
                    print("🍏 친구초대 Button Tap \(data.profileName)")
                default: break
                }

            })
            .disposed(by: disposeBag)

        contentView.rx.baseTapGesture()
            .map { [weak self] in
                self?.uiState
            }
            .bind(onNext: {
                guard case .range(let data, _) = $0 else { return }
                viewModel.friendButtonTap.accept(data)
            })
            .disposed(by: disposeBag)
    }

    private func showInteractionInformationModal(title: String,
                                                 message: String,
                                                 completeButtonName: String,
                                                 complete: @escaping () -> Void) {
        CommonModal.Builder()
            .setTitle(title)
            .setMessage(message)
            .setNagativeButton("취소") {
                $0.dismiss(animated: true)
            }
            .setNagativeButtonColor(.togetherPurple)
            .setPositiveButton(completeButtonName) {
                complete()
                $0.dismiss(animated: true)
            }
            .setPositiveButtonColor(.togetherRed)
            .build()
            .show()
    }

    private func setNewFriendUI(data: FriendInfo, isHidden: Bool = false) {
        configure(profileImageURL: data.imgUrl, title: data.profileName)

        if !data.isInvite {
            buttonLabel.text = localizable.friendInfoRequest()
            setButtonUI(labelColor: .togetherBlack,
                        buttonBorderColor: UIColor("#9E9E9E"),
                        buttonBorderWidth: 1,
                        buttonBackgroundColor: .togetherWhite)
        } else {
            buttonLabel.text = localizable.friendInfoRequestDone()
            setButtonUI(labelColor: .togetherWhite,
                        buttonBorderColor: .clear,
                        buttonBorderWidth: 0,
                        buttonBackgroundColor: .togetherGray3)
        }
        underLineView.isHidden = isHidden
    }

    private func setRequestUI(data: FriendInfo, isHidden: Bool = false) {
        configure(profileImageURL: data.imgUrl, title: data.profileName)

        buttonLabel.text = localizable.friendInfoRequestConfirm()
        setButtonUI(labelColor: .togetherWhite,
                    buttonBorderColor: .clear,
                    buttonBorderWidth: 0,
                    buttonBackgroundColor: .togetherPurple)
        underLineView.isHidden = isHidden
    }

    private func setRangeUI(data: RangeFriendInfo, isHidden: Bool = false) {
        configure(profileImageURL: data.imgUrl, title: data.profileName)
        underLineView.isHidden = isHidden
    }

    private func setBlockUI(data: BlockFriendInfo, isHidden: Bool) {
        configure(profileImageURL: data.imgUrl, title: data.profileName)

        buttonLabel.text = localizable.friendInfoUnblock()
        setButtonUI(labelColor: .togetherWhite,
                    buttonBorderColor: .clear,
                    buttonBorderWidth: 0,
                    buttonBackgroundColor: UIColor("#666666"))
        underLineView.isHidden = isHidden
    }

    private func setMarketingUI(data: FriendInfo, isHidden: Bool) {
        profileImageView.image = R.image.friend_default_thumbnail()
        nameLabel.text = data.profileName

        buttonLabel.text = localizable.friendInfoRequestInvite()
        setButtonUI(labelColor: .togetherBlack,
                    buttonBorderColor: UIColor("#9E9E9E"),
                    buttonBorderWidth: 1,
                    buttonBackgroundColor: .togetherWhite)
        underLineView.isHidden = isHidden
    }

    private func initButtonUI() {
        buttonLabel.text = ""
        setButtonUI(labelColor: .clear,
                    buttonBorderColor: .clear,
                    buttonBorderWidth: 0,
                    buttonBackgroundColor: .clear)
    }

    private func setButtonUI(labelColor: UIColor,
                             buttonBorderColor: UIColor,
                             buttonBorderWidth: CGFloat,
                             buttonBackgroundColor: UIColor) {
        buttonLabel.textColor = labelColor
        button.layer.borderColor = buttonBorderColor.cgColor
        button.layer.borderWidth = buttonBorderWidth
        button.backgroundColor = buttonBackgroundColor
    }

    private func layout() {
        contentView.addSubviews(profileImageView, nameLabel, button, underLineView)
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }

        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }

        button.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(44)
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(16)
        }

        underLineView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    func setLocationBlockSwipe(data: RangeFriendInfo) -> UISwipeActionsConfiguration? {
        let location = UIContextualAction(style: .normal,
                                          title: "") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            guard let self = self else { return }
            let interaction = data.isLocationBlock
            ? UpdateFriendStateInteractionCase.locationUnBlock(data)
            : UpdateFriendStateInteractionCase.locationBlock(data)
            self.friendInteractionModel?.friendInteractionButtonTap.accept(interaction)
            success(true)
        }
        location.backgroundColor = .white
        location.image = data.isLocationBlock
        ? R.image.campus_location_off()
        : R.image.campus_location_on()
        return UISwipeActionsConfiguration(actions: [location])
    }

    func setBlockDeleteSwipe(data: RangeFriendInfo) -> UISwipeActionsConfiguration? {
        let deleteTitle = localizable.friendInfoRequestRemove()
        let delete = UIContextualAction(style: .normal,
                                        title: deleteTitle) { [weak self] (_, _, success: @escaping (Bool) -> Void) in

            guard let self = self else { return }
            self.showInteractionInformationModal(title: localizable.friendInfoRequestRemoveFriend(),
                                                 message:
                                                    localizable.friendInfoRequestRemoveFriendDesc(data.profileName),
                                                 completeButtonName: localizable.friendInfoRequestRemove()) {
                self.friendInteractionModel?.friendInteractionButtonTap
                    .accept(UpdateFriendStateInteractionCase.friendDelete(data))
            }
            success(true)
        }
        delete.backgroundColor = UIColor.togetherGray1

        let blockTitle = localizable.friendInfoRequestBlock()
        let block = UIContextualAction(style: .normal,
                                       title: blockTitle) { [weak self] (_, _, success: @escaping (Bool) -> Void) in

            guard let self = self else { return }
            self.showInteractionInformationModal(title: localizable.friendInfoRequestBlockFriend(),
                                                 message:
                                                    localizable.friendInfoRequestBlockFriendDesc(data.profileName),
                                                 completeButtonName: localizable.friendInfoRequestBlock()) {
                self.friendInteractionModel?.friendInteractionButtonTap
                    .accept(UpdateFriendStateInteractionCase.friendBlock(data))
            }
            success(true)
        }
        block.backgroundColor = UIColor.togetherRed
        return UISwipeActionsConfiguration(actions: [delete, block])
    }

    private func configure(profileImageURL: String, title: String) {
        profileImageView.kf.setImage(with: URL(string: profileImageURL))
        nameLabel.text = title

        initButtonUI()
    }
}
