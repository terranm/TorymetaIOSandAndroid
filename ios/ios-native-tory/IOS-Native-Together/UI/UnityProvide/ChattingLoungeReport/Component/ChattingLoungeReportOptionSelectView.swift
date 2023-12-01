//
//  ChattingLoungeReportOptionSelectView .swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/16.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeReportOptionSelectView: UIView {

    private let disposeBag = DisposeBag()
    private let parentViewModel: ChattingLoungeReportViewModel

    private let harassSelectView = SelectView()
    private let lieSelectView = SelectView()
    private var isLieCheck = false
    private let hateSelectView = SelectView()
    private var isHateCheck = false
    private let improperSelectView = SelectView()
    private var isImproperCheck = false

    private lazy var stackView = UIStackView(arrangedSubviews: [harassSelectView,
                                                                lieSelectView,
                                                                hateSelectView,
                                                                improperSelectView])

    init(frame: CGRect = .zero, parentViewModel: ChattingLoungeReportViewModel) {
        self.parentViewModel = parentViewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(parentViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        harassSelectView.setTitle(text: localizable.chattingLoungeReportHarass())
        lieSelectView.setTitle(text: localizable.chattingLoungeReportLie())
        hateSelectView.setTitle(text: localizable.chattingLoungeReportHate())
        improperSelectView.setTitle(text: localizable.chattingLoungeReportImproper())
        stackView.spacing = 8
    }

    private func bind(_ viewModel: ChattingLoungeReportViewModel) {
        harassSelectView.rx.baseTapGesture()
            .scan(false) { lastState, _ in !lastState }
            .map { (isCheck: $0, state: ChattingLoungeReportOptionState.harass) }
            .bind(onNext: { [weak self] in
                viewModel.harassCheckboxButtonTap.accept($0.isCheck ? $0.state : .none)
                self?.harassSelectView.checkButtonTap(isCheck: $0.isCheck)
            })
            .disposed(by: disposeBag)

        lieSelectView.rx.baseTapGesture()
            .scan(false) { lastState, _ in !lastState }
            .map { (isCheck: $0, state: ChattingLoungeReportOptionState.lie) }
            .bind(onNext: { [weak self] in
                viewModel.lieCheckBoxButtonTap.accept($0.isCheck ? $0.state : .none)
                self?.lieSelectView.checkButtonTap(isCheck: $0.isCheck)
            })
            .disposed(by: disposeBag)

        hateSelectView.rx.baseTapGesture()
            .scan(false) { lastState, _ in !lastState }
            .map { (isCheck: $0, state: ChattingLoungeReportOptionState.hate) }
            .bind(onNext: { [weak self] in
                viewModel.hateCheckBoxButtonTap.accept($0.isCheck ? $0.state : .none)
                self?.hateSelectView.checkButtonTap(isCheck: $0.isCheck)
            })
            .disposed(by: disposeBag)

        improperSelectView.rx.baseTapGesture()
            .scan(false) { lastState, _ in !lastState }
            .map { (isCheck: $0, state: ChattingLoungeReportOptionState.improper) }
            .bind(onNext: { [weak self] in
                viewModel.improperCheckBoxButtonTap.accept($0.isCheck ? $0.state : .none)
                self?.improperSelectView.checkButtonTap(isCheck: $0.isCheck)
            })
            .disposed(by: disposeBag)
    }

    private func toggle(isCheck: Bool) -> Bool {
        var isCheck = isCheck
        isCheck.toggle()
        return isCheck
    }

    private func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    final class SelectView: UIView {
        private let checkBoxButton = UIImageView()
        private let nameLabel = UILabel()

        override var intrinsicContentSize: CGSize {
            let width: CGFloat = 32 + nameLabel.intrinsicContentSize.width
            let height: CGFloat = 32
            return CGSize(width: width, height: height)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            layout()
            initUI()
            self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setTitle(text: String) {
            nameLabel.text = text
        }

        func checkButtonTap(isCheck: Bool) {
            setUI(imageName: isCheck
                                   ? "chatting_rounge_report_check_on"
                                   : "chatting_rounge_report_check_off",
                                   nameColor: isCheck ? UIColor("#000000") : UIColor("#9E9E9E"))
        }

        private func setUI(imageName: String,
                           name: String? = nil,
                           nameFont: TogetherFontType? = nil,
                           nameColor: UIColor) {
            checkBoxButton.image = UIImage(named: imageName)
            if let name = name {
                nameLabel.text = name
            }
            if let nameFont = nameFont {
                nameLabel.configureFont(nameFont)
            }
            nameLabel.textColor = nameColor
        }

        private func initUI() {
            setUI(imageName: "chatting_rounge_report_check_off", nameFont: .regular14, nameColor: UIColor("#9E9E9E"))
        }

        private func layout() {
            addSubviews(checkBoxButton, nameLabel)
            checkBoxButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
            }

            nameLabel.snp.makeConstraints {
                $0.centerY.equalTo(checkBoxButton)
                $0.leading.equalTo(checkBoxButton.snp.trailing)
                $0.trailing.equalToSuperview()
            }
        }
    }
}
