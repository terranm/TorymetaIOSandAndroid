//
//  ParticipateSeminarViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import UIKit
import RxSwift
import RxCocoa

final class ParticipateSeminarViewController: RefactoringBaseViewController<ParticipateSeminarViewModel> {

    private let tableView = UITableView()
    private let upButton = UIImageView()
    private let seminarManager = SeminarManager()

    override func attribute() {
        super.attribute()
        tableView.separatorStyle = .none
        tableView.register(ParticipateSeminarHeaderTableViewCell.self,
                    forCellReuseIdentifier: String(describing: ParticipateSeminarHeaderTableViewCell.self))
        tableView.register(ParticipateDescriptionTableViewCell.self,
                    forCellReuseIdentifier: String(describing: ParticipateDescriptionTableViewCell.self))

        upButton.image = R.image.seminar_up()
    }

    override func layout() {
        super.layout()

        view.addSubviews(tableView, upButton)

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    override func bind(_ viewModel: ParticipateSeminarViewModel) {
        super.bind(viewModel)
        /*
         update
         */
        viewModel.updatePageData
            .flatMap {
                viewModel.repository.getSeminarDetail(id: viewModel.id)
            }
            .bind(to: viewModel.pageData)
            .disposed(by: disposeBag)

        /*
         PageData Binding
         */
        repository.getSeminarDetail(id: viewModel.id)
            .bind(to: viewModel.pageData)
            .disposed(by: disposeBag)

        viewModel.list?
            .filter { !$0.isEmpty }
            .drive(tableView.rx.items) { [weak self] tableView, row, data in
                guard let self = self else { return UITableViewCell() }
                let indexPath = IndexPath(row: row, section: 0)
                if row == 0 {
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier:
                                                String(describing: ParticipateSeminarHeaderTableViewCell.self),
                                             for: indexPath) as? ParticipateSeminarHeaderTableViewCell else {
                        return UITableViewCell()
                    }
                    let pageData = viewModel.pageData.value

                    if pageData.title != "" {
                        cell.configure(pageData, seminarManager)
                    }

                    cell.applyButton.rx.baseTapGesture()
                        .flatMap { [weak self] in
                            guard let self = self else { return Observable<Void>.empty() }
                            return seminarManager.seminarButtonTapUseCase(viewController: self,
                                                                   seminarId: viewModel.id,
                                                                   pageData: pageData)
                        }
                        .subscribe()
                        .disposed(by: cell.disposeBag)
                    return cell
                } else {
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier:
                                                String(describing: ParticipateDescriptionTableViewCell.self),
                                             for: indexPath) as? ParticipateDescriptionTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(data)
                    return cell
                }
            }
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
            .flatMap {
                viewModel.updatePageData.accept(())
                return Signal<Void>.just(())
            }
            .emit()
            .disposed(by: disposeBag)
    }
}
