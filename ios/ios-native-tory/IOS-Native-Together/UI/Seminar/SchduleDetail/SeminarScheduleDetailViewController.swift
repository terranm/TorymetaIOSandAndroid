//
//  SeminarScheduleDetailViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import SwiftDate
import RxSwift
import RxCocoa

final class SeminarScheduleDetailViewController: RefactoringBaseViewController<SeminarScheduleDetailViewModel> {

    private let exitNavigationButton = UIImageView()
    private let tagLabel = UILabel()
    private let tagView = UIView()
    private let myTagLabel = UILabel()
    private let myTagView = UIView()
    private let lockImgView = UIImageView()
    private let thumbnailImgView = UIImageView()
    private let tableView = UITableView()
    private let entranceButton = UIView()
    private let entranceButtonLabel = UILabel()
    private let upButton = UIImageView()

    private let reLoadPage = PublishRelay<Void>()
    private let seminarManager = SeminarManager()

    override func attribute() {
        super.attribute()

        exitNavigationButton.image = R.image.default_banner_exit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitNavigationButton)

        tagLabel.font = R.font.notoSansSemiBold(size: 10)
        tagLabel.text = "-"
        tagLabel.textColor = .togetherWhite

        tagView.layer.cornerRadius = 4

        myTagLabel.font = R.font.notoSansSemiBold(size: 10)
        myTagLabel.text = "MY"
        myTagLabel.textColor = .togetherWhite

        myTagView.backgroundColor = UIColor("#103771")
        myTagView.layer.cornerRadius = 4

        lockImgView.image = R.image.seminar_lock()

        tableView.contentInset = .init(top: 0, left: 0, bottom: 88, right: 0)
        tableView.separatorStyle = .none
        tableView.register(ParticipateDescriptionTableViewCell.self,
                    forCellReuseIdentifier: String(describing: ParticipateDescriptionTableViewCell.self))

        entranceButton.layer.cornerRadius = 22
        entranceButton.backgroundColor = .togetherPurple

        entranceButtonLabel.font = R.font.notoSansSemiBold(size: 16)
        entranceButtonLabel.text = localizable.seminarScheduleDetailEntrance()
        entranceButtonLabel.textColor = .togetherWhite

        upButton.image = R.image.seminar_up()

    }

    override func layout() {
        super.layout()
        exitNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }

        view.addSubviews(thumbnailImgView, tagView, tagLabel, myTagView, myTagLabel, lockImgView,
                         tableView, entranceButton, entranceButtonLabel, upButton)

        tagView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 50, height: 24))
            $0.bottom.equalTo(thumbnailImgView).inset(16)
            $0.leading.equalTo(thumbnailImgView).inset(26)
        }

        tagLabel.snp.makeConstraints {
            $0.center.equalTo(tagView)
        }

        myTagView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 40, height: 24))
            $0.centerY.equalTo(tagView)
            $0.leading.equalTo(tagView.snp.trailing).offset(8)
        }

        myTagLabel.snp.makeConstraints {
            $0.center.equalTo(myTagView)
        }

        lockImgView.snp.makeConstraints {
            $0.size.equalTo(34)
            $0.bottom.equalTo(thumbnailImgView).inset(11)
            $0.trailing.equalTo(thumbnailImgView).inset(21)
        }

        thumbnailImgView.snp.makeConstraints {
            $0.height.equalTo(240)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(thumbnailImgView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        entranceButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        entranceButtonLabel.snp.makeConstraints {
            $0.center.equalTo(entranceButton)
        }

        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(entranceButton.snp.top).offset(-16)
        }
    }

    override func bind(_ viewModel: SeminarScheduleDetailViewModel) {
        super.bind(viewModel)

        exitNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        reLoadPage
            .flatMap {
                viewModel.repository.getSeminarDetail(id: viewModel.id)
            }
            .bind(to: viewModel.pageData)
            .disposed(by: disposeBag)

        /*
         pageData 연결
         */
        repository.getSeminarDetail(id: viewModel.id)
            .bind(to: viewModel.pageData)
            .disposed(by: disposeBag)

        viewModel.seminarTag?
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.setTagUI(tagState: $0)
            })
            .disposed(by: disposeBag)

        viewModel.pageData
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.setEntranceButtonUI(data: $0)
            })
            .disposed(by: disposeBag)

        viewModel.isLock
            .map {
                !$0
            }
            .drive(lockImgView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.thumbnail?
            .drive(thumbnailImgView.rx.imageURL)
            .disposed(by: disposeBag)

        viewModel.list?
            .drive(tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: String(describing: ParticipateDescriptionTableViewCell.self),
                                         for: indexPath) as? ParticipateDescriptionTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(data)
                return cell
            }
            .disposed(by: disposeBag)

        entranceButton.rx.baseTapGesture()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Void>.empty() }
                let seminarManager = self.seminarManager
                let pageData = viewModel.pageData.value
                return seminarManager.seminarButtonTapUseCase(viewController: self,
                                                        seminarId: viewModel.id,
                                                        pageData: pageData)
            }
            .subscribe()
            .disposed(by: disposeBag)

        /*
         Seminar 대응
         */
        seminarManager.presentEnterMetaverse(viewController: self)
            .emit()
            .disposed(by: disposeBag)

        seminarManager.presentMySeminar()
            .emit()
            .disposed(by: disposeBag)

        seminarManager.presentApply()
            .flatMap { [weak self] in
                self?.reLoadPage.accept(())
                return Signal<Void>.just(())
            }
            .emit()
            .disposed(by: disposeBag)

        upButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .map { !($0.y > 0) }
            .bind(to: upButton.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func setTagUI(tagState: SeminarTagState) {
        seminarManager.setTagUI(tagState: tagState) { [weak self] in
            guard let self = self else { return }
            self.tagView.backgroundColor = UIColor($0.tagColorStr)
            self.tagLabel.text = $0.tagStr
        }
    }

    func setEntranceButtonUI(data: SeminarDetailResultDto) {
        seminarManager.setEntranceButtonUI(data: data) { [weak self] in
            guard let self = self else { return }
            self.myTagView.isHidden = $0.isMyTagHidden
            self.myTagLabel.isHidden = $0.isMyTagHidden

            self.entranceButtonLabel.text = $0.buttonTitle
            self.entranceButton.backgroundColor = $0.buttonBackgroundColor
        }
    }
}
