//
//  WilldImagePickerViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/03.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class WilldImagePickerViewController: RefactoringBaseViewController<WilldImagePickerViewModel> {

    override var navigationTitle: String {
        switch viewModel.type {
        case .nft:
            return localizable.imagePickerNFTPic()
        case .simple:
            return localizable.imagePickerDefaultProfile()
        }
    }
    var imageItems: [URL?] = []

    let leftBarButtonItem = UIBarButtonItem().then {
        $0.tintColor = .togetherBlack
        $0.title = localizable.profileChangeCancel()
    }

    lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 12
        let width = (view.frame.width - 32) / 2
        let height = width
        $0.itemSize = .init(width: width - 12, height: height - 12)
        $0.scrollDirection = .vertical
    }

    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.register(ImagePickerCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: ImagePickerCollectionViewCell.self))
    }

    let emptyLabel = WilldUILabel.create(
        font: .regular16,
        text: localizable.imagePickerNoPic(),
        color: .togetherGray2
    )

    override func bind(_ viewModel: WilldImagePickerViewModel) {
        super.bind(viewModel)

        viewModel.presentImageItems
            .drive(onNext: { [weak self] in
                self?.imageItems = $0
                self?.imageCollectionView.reloadData()
            })
            .disposed(by: disposeBag)

        imageCollectionView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)

        imageCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        leftBarButtonItem.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.presentImageItems
            .map { $0.count }
            .map { $0 > 0 }
            .drive(emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)

        imageCollectionView.rx.contentOffset
            .map { [weak self] contentOffset -> Bool in
                guard let self = self else { return false }
                let contentOffsetY = contentOffset.y
                /*
                 변화하는 전체 Size
                 */
                let contentSize   = self.imageCollectionView.contentSize.height

                let paginationY = contentSize * 0.5

                return contentOffsetY > contentSize - paginationY
            }
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: viewModel.paging)
            .disposed(by: disposeBag)
    }

    override func attribute() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    override func layout() {
        view.addSubviews(imageCollectionView, emptyLabel)

        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalTo(imageCollectionView)
        }
    }
}

extension WilldImagePickerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageItems.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: ImagePickerCollectionViewCell.self),
                                 for: indexPath) as? ImagePickerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(url: imageItems[indexPath.row])
        cell.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.dismiss(animated: true) {
                    let image = cell.pickerImageView.image
                    self?.viewModel.selectAlbumImage.accept(image)
                }
            })
            .disposed(by: cell.disposeBag)
        return cell
    }
}

// struct Preview: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            let rootViewController = WilldImagePickerViewController()
//            let viewModel = WilldImagePickerViewModel()
//            rootViewController.bind(viewModel)
//            return rootViewController
//        }
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//        typealias UIViewControllerType = UIViewController
//    }
// }
