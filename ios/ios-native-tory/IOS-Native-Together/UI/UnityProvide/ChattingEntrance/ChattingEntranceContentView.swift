//
//  ChattingEntranceContentView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/06/30.
//

// swiftlint:disable all
import UIKit
import UITextView_Placeholder

// MARK: - Title View

final class ChattingEntranceTitleView: UIView {

    private let titleLabel = UILabel()
    private(set) var warningLabel = UILabel()
    private(set) var titleTextField = UITextField()
    private let titleBorder = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let attributeFont12 = UIFont(name: AppConfigure.TEXT_BOLD, size: 12) else { return }
        titleLabel.attributedText = NSMutableAttributedString()
            .attributed("제목", font: attributeFont12, color: .black)
            .attributed("＊", font: attributeFont12, color: .red)
        warningLabel.text = "※ 필수 입력 값입니다."
        warningLabel.textColor = UIColor("#FF0000")
        warningLabel.font = .systemFont(ofSize: 6)
        titleTextField.clipsToBounds = true
        titleTextField.attributedPlaceholder = NSMutableAttributedString()
            .attributed("채팅방 개설 제목을 입력해 주세요.", font: attributeFont12, color: .lightGray)
        titleTextField.backgroundColor = UIColor("#F8F8FA")
        titleTextField.layer.cornerRadius = 6
        titleTextField.addPadding(10)
        titleTextField.font = .systemFont(ofSize: 12)
        titleBorder.backgroundColor = UIColor("#F8F8FA")

        addSubviews(titleLabel, warningLabel, titleTextField, titleBorder)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(18)
            $0.centerY.equalTo(titleTextField.snp.centerY)
            $0.width.equalTo(74)
        }

        warningLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(titleLabel)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalTo(snp.right).offset(-26)
            $0.height.equalTo(30)
        }
        titleBorder.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(4)
            $0.left.equalTo(snp.left).offset(18)
            $0.right.equalTo(snp.right).offset(-12)
            $0.height.equalTo(1)
        }
    }
}

// MARK: - Desc View

final class ChattingEntranceDescView: UIView {

    private let descLabel = UILabel()
    private(set) var descTextView = UITextView()
    private let descBorder = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let attributeFont10 = UIFont(name: AppConfigure.TEXT_BOLD, size: 10),
              let attributeFont12 = UIFont(name: AppConfigure.TEXT_BOLD, size: 12)else { return }
        descLabel.attributedText = NSMutableAttributedString()
            .attributed("방소개", font: attributeFont10, color: .black)
            .attributed(" (선택)", font: attributeFont12, color: UIColor("#6C5CE7"))
        descTextView.attributedPlaceholder = NSMutableAttributedString()
            .attributed("  채팅방 소개 글을 입력해 주세요.", font: attributeFont12, color: .lightGray)
        descTextView.layer.cornerRadius = 6
        descTextView.backgroundColor = UIColor("#F8F8FA")
        descTextView.contentInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        descTextView.font = .systemFont(ofSize: 12)
        descBorder.backgroundColor = UIColor("#F8F8FA")

        addSubviews(descLabel, descTextView, descBorder)
        descLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.left.equalToSuperview().offset(18)
            $0.width.equalTo(74)
        }
        descTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.left.equalTo(descLabel.snp.right).offset(8)
            $0.right.equalTo(snp.right).offset(-26)
            $0.height.equalTo(48)
        }
        descBorder.snp.makeConstraints {
            $0.top.equalTo(descTextView.snp.bottom).offset(4)
            $0.left.equalTo(snp.left).offset(18)
            $0.right.equalTo(snp.right).offset(-12)
            $0.height.equalTo(1)
        }
    }
}

// MARK: - Public Option View

final class ChattingEntrancePublicOptionView: UIView {

    private let isPublicLabel = UILabel()
    private(set) var publicButton = UIButton()
    private(set) var privateButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let attributeFont12 = UIFont(name: AppConfigure.TEXT_BOLD, size: 12) else { return }
        isPublicLabel.attributedText = NSMutableAttributedString()
            .attributed("공개여부", font: attributeFont12, color: .black)
            .attributed("＊", font: attributeFont12, color: .red)

        publicButton.setImage(R.image.chat_enterance_off(), for: .normal)
        publicButton.setImage(R.image.chat_enterance_on(), for: .selected)
        publicButton.setTitle("공개", for: .normal)
        publicButton.setTitleColor(.black, for: .normal)
        publicButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        publicButton.titleLabel?.configureFont(.bold14)
        publicButton.isSelected = true

        privateButton.setImage(R.image.chat_enterance_off(), for: .normal)
        privateButton.setImage(R.image.chat_enterance_on(), for: .selected)
        privateButton.setTitle("비공개", for: .normal)
        privateButton.setTitleColor(.black, for: .normal)
        privateButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        privateButton.titleLabel?.configureFont(.bold14)

        addSubviews(isPublicLabel, publicButton, privateButton)
        isPublicLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(13)
            $0.left.equalTo(snp.left).offset(18)
            $0.width.equalTo(74)
        }

        publicButton.snp.makeConstraints {
            $0.centerY.equalTo(isPublicLabel.snp.centerY)
            $0.left.equalTo(isPublicLabel.snp.right).offset(8)
            $0.size.equalTo(44)
        }

        privateButton.snp.makeConstraints {
            $0.centerY.equalTo(isPublicLabel.snp.centerY)
            $0.left.equalTo(publicButton.snp.right).offset(20)
            $0.size.equalTo(CGSize(width: 60, height: 44))
        }
    }
}
