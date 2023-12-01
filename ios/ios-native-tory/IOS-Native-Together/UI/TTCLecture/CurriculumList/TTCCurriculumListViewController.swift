//
//  TTCCurriculumListViewController.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class TTCCurriculumListViewController: RefactoringBaseViewController<TTCCurriculumListViewModel>,
                                             UITableViewDelegate {
    override var navigationTitle: String { localizable.curriculumTitle() }
    private let cellID = "ttcCurriculumListCell"
    private let tableView = UITableView()
    private let loginViewModel = TTCLoginViewModel()
    private let refreshControl = UIRefreshControl()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkNeedLogin()
    }

    override func attribute() {
        super.attribute()
        tableView.register(TTCCurriculumListTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    override func layout() {
        super.layout()
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: TTCCurriculumListViewModel) {
        super.bind(viewModel)
        loginViewModel.loginStatusRelay
            .bind { [weak self] loginStatus in
                self?.loginResult(loginStatus)
            }
            .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource
        <TTCCurriculumListViewModel.CurriculumSectionModel> { [weak self] _, tableView, indexPath, item in
            guard let self, let cell = tableView
                .dequeueReusableCell(withIdentifier: self.cellID,
                                     for: indexPath) as? TTCCurriculumListTableViewCell else {
                return UITableViewCell()
            }
            cell.lectureListInfo = item
            return cell
        }
        viewModel.curriculumListRelay
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.curriculumListRelay
            .bind { [weak self] _ in
                self?.refreshControl.endRefreshing()
                UIView.transition(with: self!.tableView, duration: 0.25) {
                    self?.tableView.reloadData()
                }
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(TTCCurriculumListViewModel.CurriculumSectionModel.Item.self)
            .throttle(.seconds(3), scheduler: MainScheduler.instance)
            .bind { [weak self] item in
                self?.didSelectedCurriculum(item)
            }
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .bind { [weak self]  in
                self?.refreshControl.beginRefreshing()
                self?.viewModel.refreshCurrculumList()
            }
            .disposed(by: disposeBag)
    }

    private func checkNeedLogin() {
        guard !viewModel.isTTCLoggedIn else { return }
        let loginViewController = TTCLoginViewController(viewModel: loginViewModel)
        presentViewController(viewController: loginViewController,
                              modalTransitionStyle: .coverVertical,
                              modalPresentationStyle: .fullScreen)
    }

    private func loginResult(_ loginStatus: TTCLoginViewModel.LoginStatus) {
        switch loginStatus {
        case .cancel:
            navigationController?.popViewController(animated: true)
        case .authorized:
            viewModel.refreshCurrculumList()
        default:
            break
        }
    }

    private func didSelectedCurriculum(_ item: TTCCurriculumListViewModel.CurriculumSectionModel.Item) {
        let lectureInfo = TTCLectureSubRequestParams(wrId: item.wrId, lecId: item.lecId)
        let lectureViewModel = TTCLectureViewModel(viewModel, lectureInfo)
        let lectureViewController = TTCLectureViewController(subject: item.subject, viewModel: lectureViewModel)
        pushViewController(viewController: lectureViewController)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.pageOffset - 1 else { return }
        viewModel.getCurriculumList()
    }
}
