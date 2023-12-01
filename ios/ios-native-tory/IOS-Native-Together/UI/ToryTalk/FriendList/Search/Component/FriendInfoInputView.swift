//
//  FriendInfoInputView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/10.
//

import Foundation
import RxSwift
import RxCocoa

final class FriendInfoInputView: UIView {
    private let disposeBag = DisposeBag()
    private(set) var parentViewModel: FriendSearchViewModel
    private let titleLabel = WilldUILabel.create(font: .regular16,
                                         text: "",
                                         color: .togetherBlack)

    private let imageView = WilldUIImageView.create(size: 44,
                                                    assetsName: R.image.friend_search_category_select.name,
                                                    type: .plain)

    private let searchBackView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor("#9E9E9E").cgColor
    }

    private lazy var searchTextField = WilldUITextField(.init(fontType: .regular16,
                                                              placeholder: localizable.friendInfoInputDesc()))
//    private let searchTextField = WilldUITextField.create(fontType: .regular16,
//                                                          placeholder: "친구 프로필명 혹은 휴대폰번호를 입력하세요",
//                                                          textColor: .togetherBlack,
//                                                          keyboardType: .default,
//                                                          textAlignment: .left,
//                                                          clearButtonMode: .whileEditing)

    override var intrinsicContentSize: CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 44 + 20 + 44
        return CGSize(width: width, height: height)
    }

    init(frame: CGRect = .zero, parentViewModel: FriendSearchViewModel) {
        self.parentViewModel = parentViewModel
        super.init(frame: frame)
        layout()
        bind(parentViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(_ viewModel: FriendSearchViewModel) {
        viewModel.type
            .map { FriendContext.getTypeName(type: $0) }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        Observable.merge(titleLabel.rx.baseTapGesture(),
                         imageView.rx.baseTapGesture())
        .bind(onNext: {
            let new = CommonBottomModalAction(title: localizable.friendInfoInputNewFriend(),
                                              titleColor: .togetherBlack) { _ in
                viewModel.type.accept(.new)
            }
            let request = CommonBottomModalAction(title: localizable.friendInfoInputRequestList(),
                                                  titleColor: .togetherBlack) { _ in
                viewModel.type.accept(.reqeust)
            }
            let rangeIn = CommonBottomModalAction(title: localizable.friendInfoInputInCampus(),
                                                  titleColor: .togetherBlack) { _ in
                viewModel.type.accept(.rangeIn)
            }
            let rangeOut = CommonBottomModalAction(title: localizable.friendInfoInputUnknownLocate(),
                                                   titleColor: .togetherBlack) { _ in
                viewModel.type.accept(.rangeOut)
            }

            let block = CommonBottomModalAction(title: localizable.friendInfoInputBlocked(),
                                                titleColor: .togetherBlack) { _ in
                viewModel.type.accept(.block)
            }
            CommonBottomModal.Builder()
                .setActions([new, request, rangeIn, rangeOut, block])
                .build()
                .show()
        })
        .disposed(by: disposeBag)

        searchTextField.rx.text
            .bind(to: viewModel.query)
            .disposed(by: disposeBag)
    }

    private func layout() {
        addSubviews(titleLabel, imageView, searchBackView, searchTextField)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.leading.equalToSuperview().inset(16)
        }
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing)
        }
        searchBackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        searchTextField.snp.makeConstraints {
            $0.top.bottom.equalTo(searchBackView)
            $0.leading.trailing.equalTo(searchBackView).inset(20)
        }
    }
}
