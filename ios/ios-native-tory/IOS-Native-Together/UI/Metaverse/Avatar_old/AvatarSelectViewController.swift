//
//  AvatarSelectViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/08.
//

import UIKit
/*
 [:*** Unity Release:]
 */
import UnityFramework
import PanModal
import RxSwift
import RxCocoa

class AvatarSelectViewController: BaseViewController {

    var viewModel: AvatarSelectViewModel! = nil

//    private var completeDelegate: (AvatarListResultDto.Item) -> Void = { _ in }

    let titleLabel = WilldUILabel.create(font: .bold24,
                                         text: "아바타를 선택해 주세요.",
                                         color: .togetherBlack)

    let descriptionLabel = WilldUILabel.create(font: .regular14,
                                               text: "캐릭터 설정에서 변경할 수 있습니다.",
                                               color: .togetherGray_1)

    var unityView: UIView?

    let zoomInButton = WilldUIImageView.create(size: 32,
                                               assetsName: R.image.avatarSelect_Zoom_in.name,
                                               type: .plain)

    let zoomOutButton = WilldUIImageView.create(size: 32,
                                                assetsName: R.image.avatarSelect_Zoom_out.name,
                                                type: .plain)

    let rotationButton = WilldUIImageView.create(size: 32,
                                                 assetsName: R.image.avatarSelect_rotation.name,
                                                 type: .plain)

    let selectBackView = WilldUIView()
    let selectUnderLine = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        $0.backgroundColor = .togetherGray_3
    }

    let selectTitleLabel = WilldUILabel.create(font: .bold14,
                                               text: "아바타",
                                               color: .togetherPurple)

    var list: Driver<[AvatarListResultDto.Item]>! = nil

    lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 4
        let width: CGFloat = (view.frame.width - 32) / 4
        let height: CGFloat = width * 7 / 4
        $0.itemSize = .init(width: width - 4, height: height)
    }

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.register(AvatarCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: AvatarCollectionViewCell.self))
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        /*
         [:*** Unity Release:]
         */
        unity.registUnityToNative(self)

        unity.launchUnity()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ viewModel: AvatarSelectViewModel) {

        self.viewModel = viewModel

        repository.getAvatarList()
            .map { [weak self] in
                guard let self = self else { return [] }
                var list = $0
                list[0].isSelect = true
                /*
                 Unity Init....
                 */

                /*
                 [:*** Unity Release:]
                 */
                let firstItem = list[0]
                self.unity.callUnityFunction(
                    UnityManager.SWITCH_SCENE, ["scene": "SelectView",
                                                "characterId": "\(firstItem.groupCode)_\(firstItem.id)"]
                )
                return list
            }
            .bind(to: viewModel.avatarList)
            .disposed(by: bag)

        zoomInButton.rx.baseTapGesture()
            .bind(to: viewModel.zoomInButtonTap)
            .disposed(by: bag)

        zoomOutButton.rx.baseTapGesture()
            .bind(to: viewModel.zoomOutButtonTap)
            .disposed(by: bag)

        rotationButton.rx.baseTapGesture()
            .bind(to: viewModel.rotationButtonTap)
            .disposed(by: bag)

        viewModel.presentZoomInButtonTap
            .emit(onNext: { [weak self] in

                /*
                 Unity Bridge
                 */
                /*
                 [:*** Unity Release:]
                 */
                self?.unity.callUnityFunction(UnityManager.AVATAR_SELECT_SELECT_ZOOM_IN)
            })
            .disposed(by: bag)

        viewModel.presentZoomOutButtonTap
            .emit(onNext: { [weak self] in
                /*
                 [:*** Unity Release:]
                 */
                self?.unity.callUnityFunction(UnityManager.AVATAR_SELECT_SELECT_ZOOM_OUT)
            })
            .disposed(by: bag)

        viewModel.presentRotaionButtonTap
            .emit(onNext: { [weak self] in
                /*
                 [:*** Unity Release:]
                 */
                self?.unity.callUnityFunction(UnityManager.AVATAR_SELECT_SELECT_ROTATION)
            })
            .disposed(by: bag)

        /*
         아이템 선택 View
         */

        viewModel.presentAvatartList
            .drive(collectionView.rx.items) { [weak self] collectionView, row, data in
                guard let self = self else { return UICollectionViewCell() }
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: String(describing: AvatarCollectionViewCell.self),
                                         for: indexPath) as? AvatarCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(data)
                cell.imgView.rx.baseTapGesture()
                    .bind(onNext: {
                        var newValue = viewModel.avatarList.value

                        newValue.enumerated().forEach { index, _ in
                            newValue[index].isSelect = false
                        }

                        newValue[row].isSelect = !newValue[row].isSelect
                        viewModel.avatarList.accept(newValue)

                        /*
                         unity에 message 전달
                         */
                        /*
                         [:*** Unity Release:]
                         */
                        self.unity.callUnityFunction(
                            UnityManager.AVATAR_SELECT_SELECT_SELECT, ["characterId": "\(data.groupCode)_\(data.id)"]
                        )
                    })
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: bag)

        /*
         완료가 되었을때 Modal 띄우기
         */
        viewModel.presentComplete
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                /*
                 [:*** Unity Release:]
                 */
                let item = viewModel.avatarList.value.filter {
                    $0.isSelect
                }

                self.repository.myAvatar.accept(item[0])

                self.unity.unityDidUnload {
                    self.dismiss(animated: true)
                }
            })
            .disposed(by: bag)
    }

    override func attribute() {
        super.attribute()

        navigationItem.leftBarButtonItems = navManager.setItem(
            itemName: R.image.toryMeta_logo.name,
            itemSize: 0
        )

        navigationItem.rightBarButtonItems = navManager.setItem(
            text: "완료",
            textColor: .togetherPurple,
            font: .bold16
        ) { [weak self] _ in
            guard let self = self else { return }

            CommonModal.Builder()
                .setMessage("현재 아바타를 사용하시겠습니까?")
                .setPositiveButton("확인") {
                    /*
                     여기서 API를 쏜다. 그의 결과로 새로운 modal을 띄운다.
                     */
                    $0.dismiss(animated: true) {
                        self.viewModel.completeButtonTap.accept(())
                    }
                }
                .setPositiveButtonColor(.togetherPurple)
                .setNagativeButton("취소") {
                    $0.dismiss(animated: true)
                }
                .setNagativeButtonColor(.togetherBlack)
                .build()
                .show()

        }
    }

    override func layout() {
        super.layout()
        [
            titleLabel,
            descriptionLabel,
            selectBackView,
            selectUnderLine
        ].forEach {
            view.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }

        selectBackView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(270)
        }

        selectUnderLine.snp.makeConstraints {
            $0.top.equalTo(selectBackView)
            $0.leading.trailing.equalToSuperview()
        }

        [
            selectTitleLabel,
            collectionView
        ].forEach {
            selectBackView.addSubview($0)
        }

        selectTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(selectTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

    }

    func unityLayout() {
        unityView = unity.unityView
        unityView?.layer.zPosition = -1

        unityView?.subviews.forEach {
            $0.removeFromSuperview()
        }
        guard let unityView = unityView else { return }

        view.addSubview(unityView)
        unityView.snp.makeConstraints {
            let titleSize = titleLabel.intrinsicContentSize
            let descriptionSize = descriptionLabel.intrinsicContentSize
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(titleSize.height + 8 + descriptionSize.height + 32)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(selectBackView.snp.top)
        }

        unityView.addSubviews(zoomInButton, zoomOutButton, rotationButton)

        zoomInButton.snp.makeConstraints {
            $0.top.equalTo(unityView).inset(8)
            $0.trailing.equalTo(unityView).inset(16)
        }

        zoomOutButton.snp.makeConstraints {
            $0.top.equalTo(zoomInButton.snp.bottom).offset(12)
            $0.trailing.equalTo(zoomInButton)
        }

        rotationButton.snp.makeConstraints {
            $0.top.equalTo(zoomOutButton.snp.bottom).offset(12)
            $0.trailing.equalTo(zoomOutButton)
        }

        window?.makeKeyAndVisible()
        rootViewController?.setNeedsStatusBarAppearanceUpdate()
    }
}

/*
 [:*** Unity Release:]
 */
extension AvatarSelectViewController: NativeCallsProtocol {

    func showHostMainWindow(_ color: String!) {}

    func sendMessage(toMobileApp message: String!) {
        if message == "From Unity on WaitForEndOfFrame" {
            unityLayout()
        }
    }
}
