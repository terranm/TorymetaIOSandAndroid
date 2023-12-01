//
//  DecoCategoryTabView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/27.
//

import UIKit
import RxSwift

// MARK: - Category Tabs
final class DecoCategoryTabView: UIScrollView {

    typealias DecoCategoryType = AvatarDecoViewModel.DecoCategoryType
    private let disposeBag = DisposeBag()
    private let viewModel: AvatarDecoViewModel
    private let stackView = UIStackView()
    private var tabButtons = [UIButton]()
    private let indicator = UIView()

    init(frame: CGRect = .zero, _ viewModel: AvatarDecoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        showsHorizontalScrollIndicator = false
        stackView.spacing = 10
        indicator.backgroundColor = UIColor("#6C5CE7")
        tabButtons = DecoCategoryType.allCases.enumerated().map {
            AvatarDecoCategoryTabButton($0, $1.title)
        }
    }

    private func layout() {
        addSubviews(stackView, indicator)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        tabButtons.forEach { categoryTabButton in
            stackView.addArrangedSubview(categoryTabButton)
            categoryTabButton.snp.makeConstraints {
                $0.height.equalTo(40)
            }
        }
    }

    private func bind() {
        defer {
            UIView.performWithoutAnimation {
                didSelectCategoryTabButton()
            }
        }

        tabButtons.forEach { tabButton in
            tabButton.rx
                .controlEvent(.touchUpInside)
                .bind { [weak self] in
                    self?.didSelectCategoryTabButton(tabButton.tag)
                    guard let categoryType = DecoCategoryType.allCases[safe: tabButton.tag] else { return }
                    self?.viewModel.decoEventRelay.accept(.tab(category: categoryType))
                }
                .disposed(by: disposeBag)
        }

        viewModel.decoEventRelay
            .bind { [weak self] eventType in
                guard case let .tab(category) = eventType else { return }
                if let index = DecoCategoryType.allCases.firstIndex(of: category) {
                    self?.didSelectCategoryTabButton(index)
                }
            }
            .disposed(by: disposeBag)
    }

    private func didSelectCategoryTabButton(_ categoryType: Int = 0) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tabButtons.forEach { tabButton in
                tabButton.isEnabled = tabButton.tag != categoryType // categoryType.rawValue

                if tabButton.tag == categoryType { // categoryType.rawValue
                    self?.indicator.snp.remakeConstraints {
                        $0.centerX.equalTo(tabButton.snp.centerX)
                        $0.bottom.equalToSuperview()
                        $0.height.equalTo(2)
                        $0.width.equalTo(tabButton.snp.width)
                    }
                    self?.layoutIfNeeded()
                }
            }
        }
    }
}

// MARK: - Category Tab Button
final class AvatarDecoCategoryTabButton: UIButton {

    convenience init(_ tag: Int, _ title: String) {
        self.init(frame: .zero)
        attribute(tag, title)
    }

    private func attribute(_ tag: Int, _ title: String) {
        self.tag = tag
        setTitle(title, for: .normal)
        setTitleColor(UIColor("#6C5CE7"), for: .disabled)
        setTitleColor(UIColor("#9E9E9E"), for: .normal)
        titleLabel?.font = UIFont(name: AppConfigure.textBold, size: 14)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}
