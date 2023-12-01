//
//  ProfileSettingViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa
import Photos
import BSImagePicker

final class ProfileChangeViewController: RefactoringBaseViewController<ProfileChangeViewModel> {
    override var navigationTitle: String { localizable.profileChangeTitle() }

    let profileImageView = WilldUIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    let profileChangeButton = WilldUIView.createFillView(
        backgroudColor: .togetherPurple,
        heightType: .large,
        cornerRoundType: .circle
    )

    let profileChangeButtonLabel = WilldUILabel.create(
        font: .bold20,
        text: localizable.profileChangeTitle(),
        color: .togetherWhite
    )

    lazy var imagePicker = UIImagePickerController().then {
        $0.modalPresentationStyle = .fullScreen
        $0.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func bind(_ viewModel: ProfileChangeViewModel) {
        super.bind(viewModel)

        profileChangeButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.profileChangeButtonTap)
            .disposed(by: disposeBag)

        viewModel.profileImage
            .drive(profileImageView.rx.imageURL)
            .disposed(by: disposeBag)

        viewModel.presentProfileSelectCategoryAlert
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                let cameraAction = CommonBottomModalAction(title: localizable.profileChangeCamera(),
                                                           titleColor: .togetherRed) { _ in
                    WDPermissionManager.shared.checkCameraPermission {
                        switch $0 {
                        case .granted:
                            self.imagePicker.sourceType = .camera
                            self.present(self.imagePicker, animated: true)
                        case .notGranted:
                            CommonModal.Builder()
                                .setTitle(localizable.profileChangeAppSettings())
                                .setMessage(localizable.profileChangeAppSettingsDesc())
                                .setPositiveButton(localizable.profileChangeSettings()) {
                                    $0.dismiss(animated: true)
                                    self.showIOSSetting()
                                }
                                .setNagativeButton(localizable.profileChangeConfirm()) {
                                    $0.dismiss(animated: true)
                                }
                                .build()
                                .show()
                        case .notDetermined:
                            self.imagePicker.sourceType = .camera
                            self.present(self.imagePicker, animated: true)
                        }

                    }
                }
                let galleryAction = CommonBottomModalAction(title: localizable.profileChangeAlbumn(),
                                                            titleColor: .togetherRed) { _ in
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true)
                }
                let nftAction = CommonBottomModalAction(title: localizable.profileChangeNFTPic(),
                                                        titleColor: .togetherBlack) { _ in
//                    self.viewModel.imagePickerType.accept(WillPickerTypeCase.nft)
                    let imagePickerViewModel = WilldImagePickerViewModel(.nft, self.viewModel.selectAlbumImage)
                    let imagePickerViewController = WilldImagePickerViewController(viewModel: imagePickerViewModel)
                    self.presentNavigationViewController(viewController: imagePickerViewController,
                                                         title: localizable.profileChangeNFTPic())
                }
                let defaultAction = CommonBottomModalAction(title: localizable.profileChangeDefaultProfile(),
                                                            titleColor: .togetherBlack) { _ in
//                    self.viewModel.imagePickerType.accept(WillPickerTypeCase.simple)
                    let imagePickerViewModel = WilldImagePickerViewModel(.simple, self.viewModel.selectAlbumImage)
                    let imagePickerViewController = WilldImagePickerViewController(viewModel: imagePickerViewModel)

                    self.presentNavigationViewController(viewController: imagePickerViewController,
                                                         title: localizable.profileChangeDefaultProfile())
                }
                let actions = [cameraAction, galleryAction, nftAction, defaultAction]
                CommonBottomModal.Builder()
                    .setActions(actions)
                    .setCancelMessage(localizable.profileChangeCancel())
                    .build()
                    .show()
            })
            .disposed(by: disposeBag)
    }

    private func converterPHAsset(asset: PHAsset) -> UIImage? {
        let imageManager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        var thumnail: UIImage?

        imageManager.requestImage(
            for: asset,
            targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
            contentMode: .aspectFit,
            options: option
        ) { result, _ in
            thumnail = result
        }
        return thumnail
    }

    override func layout() {
        view.addSubviews(profileImageView, profileChangeButton, profileChangeButtonLabel)

        profileChangeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }

        profileChangeButtonLabel.snp.makeConstraints {
            $0.center.equalTo(profileChangeButton)
        }

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(profileChangeButton.snp.top).offset(-8)
        }

    }
}

extension ProfileChangeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.viewModel.selectAlbumImage.accept(image)
        }
    }
}
