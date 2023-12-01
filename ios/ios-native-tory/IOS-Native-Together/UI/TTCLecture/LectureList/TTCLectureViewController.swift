//
//  TTCLectureViewController.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class TTCLectureViewController: RefactoringBaseViewController<TTCLectureViewModel> {

    override var navigationTitle: String { localizable.lectureListTitle() }
    private let subjectLabel = UILabel()
    private lazy var playerViewModel = TTCLecturePlayerViewModel(viewModel)
    private lazy var videoPlayerView = TTCLecturePlayerView(playerViewModel)
    private let tableView = UITableView()
    private let cellID = "lectureViewController"
    private var videoPlayerHeightConstraint: Constraint?

    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil,
         subject: String?,
         viewModel: TTCLectureViewModel) {
        subjectLabel.text = localizable.lectureSubject() + (subject ?? "")
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil, viewModel: viewModel)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func attribute() {

        super.attribute()
        subjectLabel.font = R.font.notoSansSemiBold.callAsFunction(size: 16)
        subjectLabel.adjustsFontSizeToFitWidth = true
        tableView.register(TTCLectureTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
    }

    override func layout() {
        super.layout()
        view.addSubviews(subjectLabel, videoPlayerView, tableView)

        subjectLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }

        videoPlayerView.snp.makeConstraints {
            $0.top.equalTo(subjectLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(videoPlayerView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    func bind() {
        let dataSource = RxTableViewSectionedReloadDataSource
        <TTCLectureViewModel.LectureSectionModel> { [weak self] _, tableView, indexPath, item in
            guard let self, let cell = tableView
                .dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as? TTCLectureTableViewCell else {
                return UITableViewCell()
            }
            cell.lectureInfo = item
            return cell
        }
        viewModel.lectureListRelay
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(TTCLectureViewModel.LectureSectionModel.Item.self)
            .bind { [weak self] item in
                self?.viewModel.getVideoInfo(item)
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [weak self] indexPath in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self?.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                }
                self?.viewModel.setPlayingStatus(indexPath)
            }
            .disposed(by: disposeBag)

        viewModel.playVideoRelay
            .bind { [weak self] lectureVideoInfo in
                self?.showVideoPlayerView()
                self?.videoPlayerView.lectureVideoInfo = lectureVideoInfo
            }
            .disposed(by: disposeBag)
    }

    private func showVideoPlayerView() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.videoPlayerView.snp.updateConstraints {
                $0.height.equalTo(297)
            }
            self?.view.layoutIfNeeded()
        }
    }
}
