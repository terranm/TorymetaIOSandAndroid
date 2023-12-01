//
//  FriendStateViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/04.
//

import UIKit
import RxCocoa
import RxSwift
import PanModal

final class FriendStateViewController: RefactoringBaseViewController<FriendStateViewModel>,
                              RefactoringBasePanModalPresentable {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let profileImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let universityLabel = UILabel()
    private let locationPermissionImageView = UIImageView()
    private let underLine = UIView()
    private let nftBackView = UIView()
    private let nftInfoLabel = UILabel()
    private let underLineView2 = UIView()
    private let callButton = UIView()
    private let callButtonLabel = UILabel()
    private lazy var nftFlowLayout = UICollectionViewFlowLayout()
    private lazy var nftCollectionView = UICollectionView(frame: .zero, collectionViewLayout: nftFlowLayout)
    private let nftEmptyLabel = UILabel()

    override func attribute() {
        super.attribute()

        backgroundView.backgroundColor = .clear
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.backgroundColor = .togetherWhite

        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50

        nickNameLabel.font = R.font.notoSansSemiBold(size: 20)
        nickNameLabel.textColor = .togetherBlack

        universityLabel.font = R.font.notoSansRegular(size: 14)
        universityLabel.textColor = .togetherBlack

        underLine.backgroundColor = .togetherGray3

        nftBackView.backgroundColor = .togetherWhite
        nftBackView.layer.borderWidth = 1
        nftBackView.layer.borderColor = UIColor.togetherGray3.cgColor
        nftBackView.layer.cornerRadius = 15

        nftInfoLabel.font = R.font.notoSansRegular(size: 14)
        nftInfoLabel.text = localizable.friendStateNFTListTitle()
        nftInfoLabel.textColor = .togetherGray1

        underLineView2.backgroundColor = .togetherGray3

        callButton.layer.borderWidth = 1
        callButton.layer.borderColor = UIColor.togetherPurple.cgColor
        callButton.layer.cornerRadius = 28

        callButtonLabel.font = R.font.notoSansSemiBold(size: 20)
        callButtonLabel.text = localizable.friendStateCallButtonText()
        callButtonLabel.textColor = .togetherPurple

        nftFlowLayout.minimumLineSpacing = 9
        nftFlowLayout.minimumInteritemSpacing = 9
        let width = (view.frame.width - 32) / 3
        let heigth = width
        nftFlowLayout.itemSize = .init(width: width - 9, height: heigth)

        nftCollectionView.isScrollEnabled = false
        nftCollectionView.backgroundColor = .togetherWhite
        nftCollectionView.register(NftItemCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: NftItemCollectionViewCell.self))

        nftEmptyLabel.font = R.font.notoSansRegular(size: 16)
        nftEmptyLabel.text = localizable.friendStateNFTListEmptyMessage()
        nftEmptyLabel.textColor = .togetherGray2
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView,
                         containerView,
                         profileImageView,
                         nickNameLabel,
                         universityLabel,
                         locationPermissionImageView,
                         underLine,
                         nftBackView,
                         nftInfoLabel,
                         nftCollectionView,
                         nftEmptyLabel,
                         underLineView2,
                         callButton,
                         callButtonLabel)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView).inset(-24)
            $0.bottom.equalToSuperview().inset(-50)
            $0.leading.trailing.equalToSuperview()
        }
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.bottom.equalTo(underLine.snp.top).offset(-40)
            $0.leading.equalToSuperview().inset(16)
        }
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        universityLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nickNameLabel)
        }
        locationPermissionImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 32))
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalTo(containerView).inset(16)
        }
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalTo(nftCollectionView.snp.top).offset(-40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        nftBackView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 170, height: 30))
            $0.center.equalTo(underLine)
        }
        nftInfoLabel.snp.makeConstraints {
            $0.center.equalTo(nftBackView)
        }
        nftCollectionView.snp.makeConstraints {
            let height = ((view.frame.width - 32) / 3) * 2 + 9
            $0.height.equalTo(height)
            $0.bottom.equalTo(underLineView2.snp.top).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        nftEmptyLabel.snp.makeConstraints {
            $0.center.equalTo(nftCollectionView)
        }
        underLineView2.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalTo(callButton.snp.top).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        callButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        callButtonLabel.snp.makeConstraints {
            $0.center.equalTo(callButton)
        }
    }

    override func bind(_ viewModel: FriendStateViewModel) {
        super.bind(viewModel)
        backgroundView.rx.baseTapGesture()
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.setPageData()
            .bind(to: viewModel.pageData)
            .disposed(by: disposeBag)

        locationPermissionImageView.rx.baseTapGesture()
            .bind(to: viewModel.locationButtonTap)
            .disposed(by: disposeBag)

        callButton.rx.baseTapGesture()
            .bind(to: viewModel.callButtonTap)
            .disposed(by: disposeBag)

        viewModel.nftList()
            .drive(nftCollectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: String(describing: NftItemCollectionViewCell.self),
                                         for: indexPath) as? NftItemCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.inject = NftItemCollectionViewCell.Inject(ownerNft: data, parentViewModel: viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.nftItemButtonTap
            .bind(onNext: { [weak self] in
                guard let nftItem = $0 else { return }
                let url = NFTWebViewURL(nftDto: nftItem)
                let viewModel = CommonWebViewModel()
                let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewModel)

                self?.presentViewController(viewController: commonWebViewController,
                                            modalTransitionStyle: .coverVertical,
                                            modalPresentationStyle: .popover)
            })
            .disposed(by: disposeBag)

        viewModel.profileImage()
            .drive(profileImageView.rx.imageURL)
            .disposed(by: disposeBag)

        viewModel.profileName()
            .drive(nickNameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.universityName()
            .drive(universityLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.locationImage()
            .map { UIImage(named: $0) }
            .drive(locationPermissionImageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.locationButtonTapWithToast()
            .emit(onNext: {
                CommonToast.Builder()
                    .setMessage($0)
                    .build()
                    .show()
            })
            .disposed(by: disposeBag)

        viewModel.hiddenCallButton()
            .drive(onNext: { [weak self] in
                self?.callButton.isHidden = $0
                self?.callButtonLabel.isHidden = $0
                self?.callButton.heightAnchor.constraint(equalToConstant: $0 ? 0 : 56).isActive = true
                self?.callButtonLabel.heightAnchor.constraint(
                    equalToConstant: $0
                    ? 0
                    : self?.callButtonLabel.intrinsicContentSize.height ?? 0.0).isActive = true
            })
            .disposed(by: disposeBag)

        viewModel.callButtonTapWithSwitchCallModal()
            .emit(onNext: {
                if let url = $0,
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            .disposed(by: disposeBag)

        viewModel.hiddenNftEmptyLabel()
            .drive(nftEmptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
