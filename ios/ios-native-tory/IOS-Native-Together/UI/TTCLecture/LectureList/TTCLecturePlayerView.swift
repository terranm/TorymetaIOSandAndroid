//
//  TTCLecturePlayerView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import AVKit
import SnapKit

final class TTCLecturePlayerView: UIView {

    private let viewModel: TTCLecturePlayerViewModel
    private let playerViewController = AVPlayerViewController()
    private let descriptionLabel = UILabel()
    var lectureVideoInfo: TTCLecturePlayerInformation? {
        didSet {
            setLectureVideoInfo()
        }
    }

    init(frame: CGRect = .zero, _ viewModel: TTCLecturePlayerViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        clipsToBounds = true
        playerViewController.delegate = self

        descriptionLabel.text = localizable.lectureListDesc()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = R.font.notoSansRegular.callAsFunction(size: 14)
    }

    private func layout() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(47)
        }
    }

    private func setLectureVideoInfo() {
        viewModel.playVideo(lectureVideoInfo)
        addSubview(playerViewController.view)
        playerViewController.player = viewModel.videoPlayer
        playerViewController.view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 47)
    }
}

extension TTCLecturePlayerView: AVPlayerViewControllerDelegate {
    func playerViewController(_ playerViewController: AVPlayerViewController,
                              willEndFullScreenPresentationWithAnimationCoordinator
                              coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { _ in
            self.playerViewController.player?.play()
        }
    }
}
