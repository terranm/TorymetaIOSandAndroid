//
//  SigleCalendarViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import UIKit
import SwiftDate
import RxSwift
import RxCocoa

final class SigleCalendarViewController: RefactoringBaseViewController<SingleCalendarViewModel> {
    override var analyticsId: String { AnalyticsManager.seminarSchedule }
    override var navigationTitle: String { localizable.sigleCalendarTitle() }

    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let rightImgButton = UIImageView()
    private let leftImgButton = UIImageView()
    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    private let upButton = UIImageView()

    override func attribute() {
        super.attribute()
        titleLabel.font = R.font.notoSansSemiBold(size: 16)
        titleLabel.text = "-"
        titleLabel.textColor = .togetherBlack

        subTitleLabel.font = R.font.notoSansRegular(size: 12)
        subTitleLabel.text = "-"
        subTitleLabel.textColor = .togetherGray2

        rightImgButton.image = R.image.seminar_Calendar_right()
        leftImgButton.image = R.image.seminar_Calendar_left()

        tableView.separatorStyle = .none
        tableView.register(SingleCalenderItemTableViewCell.self,
                    forCellReuseIdentifier: String(describing: SingleCalenderItemTableViewCell.self))

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.text = localizable.sigleCalendarNoPlan()
        emptyLabel.textColor = .togetherGray3

        upButton.image = R.image.seminar_up()
    }

    override func layout() {
        super.layout()

        view.addSubviews(titleLabel, subTitleLabel, rightImgButton, leftImgButton, tableView, emptyLabel, upButton)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.centerX.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(titleLabel)
        }
        rightImgButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16)
        }
        leftImgButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel.snp.leading).offset(-16)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(36)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(108)
            $0.centerX.equalToSuperview()
        }
        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    override func bind(_ viewModel: SingleCalendarViewModel) {
        super.bind(viewModel)

        viewModel.list?
            .drive(tableView.rx.items) { [weak self] tableView, row, data in
                guard let self = self else { return UITableViewCell() }
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: String(describing: SingleCalenderItemTableViewCell.self),
                                         for: indexPath) as? SingleCalenderItemTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(data)
                cell.rx.baseTapGesture()
                    .bind(onNext: { [weak self] in
                        let participateSeminarViewModel = ParticipateSeminarViewModel(id: data.id)
                        let participateSeminarViewController
                        = ParticipateSeminarViewController(viewModel: participateSeminarViewModel)

                        self?.pushViewController(viewController: participateSeminarViewController, title: "")
                    })
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)

        rightImgButton.rx.baseTapGesture()
            .map {
                viewModel.date.value + 1.days
            }
            .bind(to: viewModel.date)
            .disposed(by: disposeBag)

        leftImgButton.rx.baseTapGesture()
            .map {
                viewModel.date.value - 1.days
            }
            .bind(to: viewModel.date)
            .disposed(by: disposeBag)

        viewModel.date
            .map {
                if $0.isToday {
                    return localizable.sigleCalendarToday()
                }

                let currentDate = Date()
                if $0.isBeforeDate(currentDate, granularity: .second) {
                    return localizable.sigleCalendarFinish()
                } else {
                    return localizable.sigleCalendarPlan()
                }
            }
            .bind(to: subTitleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.date
            .map {
                if $0.isToday {
                    return UIColor.togetherPurple
                }

                let currentDate = Date()
                if $0.isBeforeDate(currentDate, granularity: .second) {
                    return UIColor("#D9D9D9")
                } else {
                    return UIColor("#C7C0FC")
                }
            }
            .bind(to: subTitleLabel.rx.textColor)
            .disposed(by: disposeBag)

        viewModel.date
            .map {
                $0.dateToString(format: "yy.MM.dd")
            }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.list?
            .map {
                !$0.isEmpty
            }
            .drive(emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)

        upButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .map {
                !($0.y > 0)
            }
            .bind(to: upButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
