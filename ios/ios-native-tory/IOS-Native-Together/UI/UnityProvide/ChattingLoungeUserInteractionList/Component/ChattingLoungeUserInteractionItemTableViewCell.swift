//
//  ChattingLoungeUserInteractionItemTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeUserInteractionItemTableViewCell: BaseTableViewCell {

    private var disposeBag = DisposeBag()

    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let underLine = UIView()

    private lazy var stackView = UIStackView(arrangedSubviews: [
        iconImageView,
        nameLabel
    ])

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

    func bind(_ data: ChattingLoungeUserInteraction, _ viewModel: ChattingLoungeUserInteractionListViewModel) {
        contentView.rx.baseTapGesture()
            .map { data.state }
            .bind(to: viewModel.interactionButtonTap)
            .disposed(by: disposeBag)
    }

    func setUI(data: ChattingLoungeUserInteraction, isLast: Bool) {
        let image = UIImage(named: data.imageName)
        iconImageView.image = image?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor(data.colorHexName)

        nameLabel.text = data.title
        nameLabel.textColor = UIColor(data.colorHexName)

        underLine.backgroundColor = .togetherGray3
        underLine.isHidden = isLast
    }

    private func attribute() {
        nameLabel.configureFont(.regular14)
    }

    private func layout() {
        contentView.addSubviews(iconImageView, nameLabel, underLine)
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
        }

        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }

        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
