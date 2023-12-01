//
//  TTCLectureTableViewCell.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import SnapKit

final class TTCLectureTableViewCell: UITableViewCell {

    var lectureInfo: TTCLectureSubList.SubLecture? {
        didSet {
            setLectureInfo()
        }
    }
    private let borderView = UIView()
    private let titleLabel = UILabel()
    private let playIcon = UIImageView(image: R.image.lecturePlayerIcon())
    private let progressView = TTCLectureProgressView(rateType: .progress)

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
        titleLabel.font = R.font.notoSansSemiBold.callAsFunction(size: 14)
        titleLabel.numberOfLines = 2
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        borderView.backgroundColor = selected ? UIColor("#EEF1FF") : UIColor("#FFFFFF")
//    }

    private func layout() {
        contentView.addSubview(borderView)

        borderView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(59)
        }

        borderView.addSubviews(playIcon, titleLabel, progressView)

        playIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.size.equalTo(32)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(playIcon.snp.right).offset(4)
            $0.right.equalTo(progressView.snp.left).offset(-16)
        }

        progressView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(10)
            $0.size.equalTo(CGSize(width: 56, height: 34))
        }
    }

    private func setLectureInfo() {
        guard let lectureInfo else { return }
        titleLabel.text = lectureInfo.title
        progressView.progressRate = lectureInfo.process
        borderView.backgroundColor = lectureInfo.isPlaying ? UIColor("#EEF1FF") : UIColor("#FFFFFF")
    }
}
