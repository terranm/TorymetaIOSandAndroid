//
//  TTCLecturePlayerViewModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 10/10/23.
//

import Foundation
import AVKit
import RxSwift

final class TTCLecturePlayerViewModel {

    private let disposeBag = DisposeBag()
    private let repository = WDRepository.shared
    private(set) var videoPlayer: AVPlayer?
    private var timeObserver: Any?
    struct PlayingInfo {
        let currentTime, duration: Double
    }
    private var playingInfo: PlayingInfo?
    var playTimerDisposable: Disposable?
    private var lectureVideoInfo: TTCLecturePlayerInformation?
    private let lectureViewModel: TTCLectureViewModel

    init(_ lectureViewModel: TTCLectureViewModel) {
        self.lectureViewModel = lectureViewModel
    }

    deinit {
        removePeriodicTimeObserver()
    }

    // MARK: - Playback

    func playVideo(_ lectureVideoInfo: TTCLecturePlayerInformation?) {
        removeVideo()

        self.lectureVideoInfo = lectureVideoInfo

        guard let contentUrl = lectureVideoInfo?.contentUrl, let videoURL = URL(string: contentUrl) else { return }
        let playerItem = AVPlayerItem(url: videoURL)
        videoPlayer = AVPlayer(playerItem: playerItem)
        videoPlayer?.replaceCurrentItem(with: playerItem)
        if let startAt = lectureVideoInfo?.curpos {
            videoPlayer?.seek(to: CMTime(seconds: startAt, preferredTimescale: 600))
        }
        videoPlayer?.play()

        addPeriodicTimeObserver()
        startRecordTimer()
    }

    private func removeVideo() {
        guard let videoPlayer else { return }
        videoPlayer.pause()
        videoPlayer.replaceCurrentItem(with: nil)
        self.videoPlayer = nil

        removePeriodicTimeObserver()
        endRecordTimer()
    }

    // MARK: - Player Time Observer

    private func addPeriodicTimeObserver() {
        let interval = CMTime(value: 600, timescale: 600)
        timeObserver = videoPlayer?
            .addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                guard let self else { return }
                let currentTime = time.seconds
                let duration = self.videoPlayer?.currentItem?.duration.seconds ?? 0
                playingInfo = PlayingInfo(currentTime: currentTime, duration: duration)
                if currentTime == duration {
                    self.sendStudyOnCompleteTime()
                }
            }
    }

    private func removePeriodicTimeObserver() {
        guard let timeObserver else { return }
        videoPlayer?.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }

    // MARK: - Save study progress

    private func startRecordTimer() {
        playTimerDisposable = Observable<Int>
            .timer(.seconds(1), period: .seconds(10), scheduler: MainScheduler.instance)
            .skip(1)
            .subscribe { [weak self] _ in
                self?.saveStudyOnProgressTime()
            }
        playTimerDisposable?.disposed(by: disposeBag)
    }

    private func endRecordTimer() {
        playTimerDisposable?.dispose()
        playTimerDisposable = nil
    }

    // 동영상 강의의 현재 진도율을 저장한다.
    private func saveStudyOnProgressTime() {
        guard let playingInfo, playingInfo.currentTime < playingInfo.duration,
              let lectureVideoInfo, lectureVideoInfo.isStudied == false, // 학습 완료한 아이템인 경우 진행바 갱신 안함
              videoPlayer?.timeControlStatus == .playing else { return }
        let params = TTCUpdateLectureRequestParams(applyId: lectureVideoInfo.applyId,
                                                   lecId: lectureVideoInfo.lecId,
                                                   wrOrder: lectureVideoInfo.wrOrder,
                                                   lmsTimeId: lectureVideoInfo.lmsTimeId,
                                                   isStudied: lectureVideoInfo.isStudied,
                                                   contentTime: playingInfo.duration,
                                                   curpos: playingInfo.currentTime)
        repository.updateTTCLecturePosition(params: params)
            .subscribe { [weak self] updateSucceed in
                guard updateSucceed else { return }
                self?.syncLectureProgressBar()
            }.disposed(by: disposeBag)
    }

    // 동영상 강의 수강을 완료 했음을 저장한다.
    private func sendStudyOnCompleteTime() {
        // 학습 완료한 아이템인 경우 진행바 갱신 안함
        guard let playingInfo, let lectureVideoInfo, lectureVideoInfo.isStudied == false else { return }
        let params = TTCUpdateLectureEndParams(applyId: lectureVideoInfo.applyId,
                                               lecId: lectureVideoInfo.lecId,
                                               wrOrder: lectureVideoInfo.wrOrder,
                                               lmsTimeId: lectureVideoInfo.lmsTimeId,
                                               isStudied: false,
                                               endCk: "y",
                                               time: playingInfo.currentTime,
                                               contentTime: playingInfo.duration)
        repository.updateTTCLectureEnd(params: params)
            .subscribe { [weak self] updateSucceed in
                guard updateSucceed else { return }
                self?.syncLectureProgressBar()
                self?.syncCurriculumProgressBar()
            }
            .disposed(by: disposeBag)
    }

    // MARK: 나의 강의실 목록의 진도율을 동기화한다.
    private func syncLectureProgressBar() {
        guard let lectureVideoInfo, let playingInfo,
              var items = lectureViewModel.lectureListRelay.value.first?.items,
              var item = items.enumerated().filter({ $1.wrOrder == lectureVideoInfo.wrOrder }).first else { return }
        guard !(playingInfo.currentTime.isNaN || playingInfo.currentTime.isInfinite ||
                playingInfo.duration.isNaN || playingInfo.duration.isInfinite) else {
            print("⛔️ Found Nan or infinite" +
                  "\(playingInfo.currentTime.isNaN) \(playingInfo.currentTime.isInfinite)" +
                  "\(playingInfo.duration.isNaN) \(playingInfo.duration.isInfinite)")
            return
        }
        item.element.process = Int(playingInfo.currentTime / playingInfo.duration * 100) // 재생 시간 갱신
        items[item.offset] = item.element // 갱신된 아이템을 리스트에 추가
        lectureViewModel.lectureListRelay.accept([TTCLectureViewModel.LectureSectionModel(model: "", items: items)])
    }

    // MARK: 강의 리스트 목록의 출석률을 동기화한다.
    private func syncCurriculumProgressBar() {
        // TODO: 나의 강의실 목록의 프로그레스바 갱신은 안드로이드와 동일하게 우선은 풀 투 리프레시로 대응하기로 팀장님으로부터 전달 받음
        return
        guard let lectureVideoInfo,
              var items = lectureViewModel.curriculumViewModel.curriculumListRelay.value.first?.items,
              var item = items.enumerated().filter({ $1.lecId == lectureVideoInfo.lecId }).first else { return }
//        item.element.totalProcess = <#출석률: Int#> // 전체 강좌중에서 studied가 true인 비율을 어떻게 구하지??
        items[item.offset] = item.element
        lectureViewModel.curriculumViewModel.curriculumListRelay
            .accept([TTCCurriculumListViewModel.CurriculumSectionModel(model: "", items: items)])
    }
}
