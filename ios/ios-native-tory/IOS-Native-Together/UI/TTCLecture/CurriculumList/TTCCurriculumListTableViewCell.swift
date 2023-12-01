//
//  TTCCurriculumListTableViewCell.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import SnapKit

final class TTCCurriculumListTableViewCell: UITableViewCell {

    enum CategoryType: String {
        case altOffline = "오프라인대체"
        case directLect = "저자직강"
        case realtimeLect = "실시간줌강의"
        case videoLecture = "영상강의"
        case specialLecture = "특강"
    }

    var lectureListInfo: TTCLectureList.Lecture? {
        didSet {
            setLectureListInfo()
        }
    }
    private let borderView = UIView()
    private let categoryLabel = UILabel() // TTCCurriculumCategoryLabel()
    private let titleLabel = UILabel()
    private let preiodLabel = UILabel()
    private let progressView = TTCLectureProgressView(rateType: .attendance)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        selectionStyle = .none
        borderView.clipsToBounds = true
        borderView.layer.cornerRadius = 8
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor("#D9D9D9").cgColor
        categoryLabel.font = R.font.notoSansRegular.callAsFunction(size: 12)
        titleLabel.font = R.font.notoSansSemiBold.callAsFunction(size: 14)
        titleLabel.numberOfLines = 1
        preiodLabel.font = R.font.notoSansRegular.callAsFunction(size: 10)

        categoryLabel.textAlignment = .center
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 8
//        categoryLabel.setContentHuggingPriority(.required, for: .horizontal)
    }

    private func layout() {
        contentView.addSubview(borderView)

        borderView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(59)
        }

        borderView.addSubviews(categoryLabel, titleLabel, preiodLabel, progressView)

        categoryLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: 77, height: 32))
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.top).offset(-1)
            $0.left.equalTo(categoryLabel.snp.right).offset(4)
            $0.right.equalTo(progressView.snp.left).offset(-16)
        }

        preiodLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.bottom.equalTo(categoryLabel.snp.bottom)
            $0.right.equalTo(progressView.snp.left).offset(-16)
        }

        progressView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(13)
            $0.right.equalToSuperview().inset(10)
            $0.size.equalTo(CGSize(width: 56, height: 34))
        }
    }

    private func setLectureListInfo() {
        guard let lecture = lectureListInfo else { return }
        categoryLabel.text = lecture.cat
        titleLabel.text = lecture.subject
        preiodLabel.text = "\(lecture.start) ~ \(lecture.end)"
        progressView.progressRate = lecture.totalProcess
        categoryLabel.backgroundColor = getCategoryBGColor(lecture.cat)
        contentView.layoutIfNeeded()
    }

    private func getCategoryBGColor(_ categoryType: String) -> UIColor {
        switch categoryType {
        case CategoryType.altOffline.rawValue, CategoryType.directLect.rawValue:
            return UIColor("#ACB9FF")
        case CategoryType.videoLecture.rawValue:
            return UIColor("#FFE3AC")
        case CategoryType.realtimeLect.rawValue:
            return UIColor("#FFB6AC")
        case CategoryType.specialLecture.rawValue:
            return UIColor("#ACE1FF")
        default:
            return UIColor("#ACB9FF")
        }
    }
}

final class TTCCurriculumCategoryLabel: UILabel {

    private let padding = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
