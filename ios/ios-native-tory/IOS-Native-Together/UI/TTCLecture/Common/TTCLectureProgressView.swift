//
//  TTCLectureProgressView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 10/11/23.
//

import UIKit
import SnapKit

final class TTCLectureProgressView: UIView {

    enum RateType {
        case attendance, progress
    }

    var progressRate: Int? {
        didSet {
            setProgressRate()
        }
    }

    private let rateType: RateType
    private let progressLabel = UILabel()
    private let progressBar = UIProgressView(progressViewStyle: .bar)

    init(frame: CGRect = .zero, rateType: RateType) {
        self.rateType = rateType
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        progressLabel.font = R.font.notoSansRegular.callAsFunction(size: 10)
        progressLabel.textColor = UIColor("#000000")
        progressBar.tintColor = rateType == .attendance ? UIColor("#ACB9FF") : UIColor("#6C5CE7")
        progressBar.backgroundColor = UIColor("#D9D9D9")
        progressBar.clipsToBounds = true
        progressBar.layer.cornerRadius = 2
    }

    private func layout() {
        addSubviews(progressLabel, progressBar)

        progressLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(snp.centerY)
            $0.height.equalTo(14)
        }

        progressBar.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    private func setProgressRate() {
        guard let progressRate else { return }
        let progressTitle = rateType == .progress ? localizable.lectureAttendance() : localizable.lectureProgress()
        progressLabel.text = "\(progressTitle) \(progressRate)%"
        progressBar.setProgress(Float(progressRate) / 100, animated: false)
    }
}
