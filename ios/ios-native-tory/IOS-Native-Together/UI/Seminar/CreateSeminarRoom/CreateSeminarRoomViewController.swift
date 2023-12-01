//
//  CreateSeminarRoomViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa
import CoreActionSheetPicker
import SwiftDate

final class CreateSeminarRoomViewController: RefactoringBaseViewController<CreateSeminarRoomViewModel> {
    override var navigationTitle: String { localizable.createSeminarRoom() }

    private var allCnt: Int = 7
    private let exitNavigationButton = UIImageView()

    private let tableView = UITableView()
    private let completeButtonLabel = UILabel()
    private let completeButton = UIView()
    private let completeBlurView = UIView()
    private let upButton = UIImageView()

    /*
     정적으로 생성: 미리 생성
     */
    private var seminarRoomSelectTableViewCell: CreateRoomSelectSeminarRoomSelectTableViewCell?
    = CreateRoomSelectSeminarRoomSelectTableViewCell()

    private var seminarRoomCurrentPage: Int = 0

    override func attribute() {
        super.attribute()

        exitNavigationButton.image = R.image.default_banner_exit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitNavigationButton)

        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = .init(top: 0, left: 0, bottom: 88, right: 0)
        tableView.separatorStyle = .none
        tableView.register(CreateRoomInputTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CreateRoomInputTableViewCell.self))
        tableView.register(CreateRoomFixTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CreateRoomFixTableViewCell.self))
        tableView.register(CreateRoomScheduleTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CreateRoomScheduleTableViewCell.self))
        tableView.register(CreateRoomURLPathTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CreateRoomURLPathTableViewCell.self))
        tableView.register(CreateRoomSelectSeminarRoomSelectTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CreateRoomSelectSeminarRoomSelectTableViewCell.self))
        tableView.register(CreateRoomOtherSettingTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CreateRoomOtherSettingTableViewCell.self))
        completeButtonLabel.font = R.font.notoSansSemiBold(size: 20)
        completeButtonLabel.text = localizable.createSeminarOpen()
        completeButtonLabel.textColor = .togetherWhite

        completeButton.layer.cornerRadius = 28
        completeButton.backgroundColor = .togetherGray3
        completeButton.addSubview(completeButtonLabel)

        completeBlurView.backgroundColor = .togetherWhite.withAlphaComponent(0.9)

        upButton.image = R.image.seminar_up()

    }

    override func layout() {
        super.layout()

        view.addSubviews(tableView, completeBlurView, completeButton, completeButtonLabel, upButton)

        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        completeButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
        }

        completeButtonLabel.snp.makeConstraints {
            $0.center.equalTo(completeButton)
        }

        completeBlurView.snp.makeConstraints {
            $0.top.equalTo(completeButton)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.bottom.equalTo(completeButton.snp.top).offset(-16)
            $0.trailing.equalTo(completeButton)
        }
    }

    // swiftlint:disable function_body_length
    override func bind(_ viewModel: CreateSeminarRoomViewModel) {
        super.bind(viewModel)

        exitNavigationButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }

                if self.viewModel.id == CreateSeminarRoomViewModel.NEW {
                    CommonModal.Builder()
                        .setMessage(localizable.createSeminarCancel())
                        .setPositiveButton(localizable.createSeminarModifyConfirm()) {
                            $0.dismiss(animated: true)
                            self.dismiss(animated: true)
                        }
                        .setPositiveButtonColor(.togetherBlack)
                        .setNagativeButton(localizable.createSeminarIgnore()) {
                            $0.dismiss(animated: true)
                        }
                        .setNagativeButtonColor(.togetherPurple)
                        .build()
                        .show()
                } else {
                    CommonModal.Builder()
                        .setMessage(localizable.createSeminarOutDesc())
                        .setPositiveButton(localizable.createSeminarClose()) {
                            $0.dismiss(animated: true)
                            self.dismiss(animated: true)
                        }
                        .setPositiveButtonColor(.togetherBlack)
                        .setNagativeButton(localizable.createSeminarModify()) {
                            $0.dismiss(animated: true)
                        }
                        .setNagativeButtonColor(.togetherPurple)
                        .build()
                        .show()
                }
            })
            .disposed(by: disposeBag)

        tableView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.seminarList
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.allCnt = 7
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel.roomTag
            .map {
                switch $0 {
                case 0:     return "ALL"
                case 1:     return "SMALL"
                case 2:     return "MEDIUM"
                case 3:     return "LARGE"
                default:    return "ALL"
                }
            }
            .flatMap { [weak self] roomSize -> Observable<[SeminarRoomTypeListResultDto.Item]> in
                guard let self = self else { return Observable.just([]) }
                return self.repository.getCreateSeminarRoomList(roomSize: roomSize)
            }
            .bind(to: viewModel.seminarList)
            .disposed(by: disposeBag)

        viewModel.completeStr
            .drive(completeButtonLabel.rx.text)
            .disposed(by: disposeBag)

        /*
         Complete
         */
        viewModel.presentCompleteButtonTap
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                if $0 {
                    self.viewModel.parentListUpdate?.accept(())
                    /*
                     SeminarMainUpdate
                     */
                    self.repository.seminarMainReload.accept(())
                    /*
                     MainPage Update
                     */
//                    self.repository.newMainSeminarLeeLoad.accept(())

                    /*
                     Modal 띄우는거 분기
                     */
                    if self.viewModel.id == CreateSeminarRoomViewModel.NEW {
                        CommonModal.Builder()
                            .setTitle(localizable.createSeminarSuccess())
                            .setTitleFont(.bold16)
                            .setMessage(localizable.createSeminarSuccessDesc())
                            .setMessageFont(.regular12)
                            .setMessageColor(.togetherGray2)
                            .setPositiveButton(localizable.createSeminarConfirm()) {
                                $0.dismiss(animated: true) {
                                    self.dismiss(animated: true)
                                }
                            }
                            .setPositiveButtonColor(.togetherPurple)
                            .build()
                            .show()
                    } else {
                        CommonModal.Builder()
                            .setMessage(localizable.createSeminarUpdateSuccess())
                            .setPositiveButton(localizable.createSeminarConfirm()) {
                                $0.dismiss(animated: true) {
                                    self.dismiss(animated: true)
                                }
                            }
                            .setPositiveButtonColor(.togetherPurple)
                            .build()
                            .show()
                    }
                } else {
                    CommonModal.Builder()
                        .setTitle(localizable.createSeminarAlertTitle())
                        .setMessage(localizable.createSeminarError())
                        .setPositiveButton(localizable.createSeminarConfirm()) {
                            $0.dismiss(animated: true)
                        }
                        .setPositiveButtonColor(.togetherPurple)
                        .build()
                        .show()
                }
            })
            .disposed(by: disposeBag)

        /*
         완료 되었을때
         */
        viewModel.isPossibleCompleteObservable()
            .map { $0 ? UIColor.togetherPurple: UIColor.togetherGray3 }
            .bind(to: completeButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        completeButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if self.viewModel.isPossibleComplete() {
                    if self.viewModel.id == CreateSeminarRoomViewModel.NEW {
                        self.viewModel.completeButtonTap.accept(())
                    } else {
                        CommonModal.Builder()
                            .setMessage(localizable.createSeminarModifyAlertTitle())
                            .setPositiveButton(localizable.createSeminarModifyConfirm()) {
                                $0.dismiss(animated: true) {
                                    self.viewModel.completeButtonTap.accept(())
                                }
                            }
                            .setPositiveButtonColor(.togetherPurple)
                            .setNagativeButton("아니오") {
                                $0.dismiss(animated: true)
                            }
                            .build()
                            .show()
                    }

                } else {
                    CommonModal.Builder()
                        .setMessage(localizable.createSeminarRequiredAlert())
                        .setPositiveButton(localizable.createSeminarConfirm()) {
                            $0.dismiss(animated: true)
                        }
                        .setPositiveButtonColor(.togetherPurple)
                        .build()
                        .show()
                }
            })
            .disposed(by: disposeBag)

        upButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .map { !($0.y > 0) }
            .bind(to: upButton.rx.isHidden)
            .disposed(by: disposeBag)

        /*
         PAGE Data 바인딩
         */
        if viewModel.id != CreateSeminarRoomViewModel.NEW {
            let pageData = repository.getSeminarDetail(id: viewModel.id)

            pageData
                .map { $0.title }
                .bind(to: viewModel.title)
                .disposed(by: disposeBag)

            pageData
                .map { $0.description }
                .bind(to: viewModel.craeteDescription)
                .disposed(by: disposeBag)

            pageData
                .map { $0.teacherName }
                .bind(to: viewModel.teacher)
                .disposed(by: disposeBag)

            pageData
                .map { $0.startDate }
                .bind(to: viewModel.startDate)
                .disposed(by: disposeBag)

            pageData
                .map { $0.endDate }
                .bind(to: viewModel.endDate)
                .disposed(by: disposeBag)

            pageData
                .map { $0.seminarUrl }
                .bind(to: viewModel.urlPath)
                .disposed(by: disposeBag)

            viewModel.seminarList
                .take(2)
                .filter { !$0.isEmpty }
                .flatMap { _ in
                    pageData
                }
                .map {
                    var items = viewModel.seminarList.value
                    for index in 0..<items.count {
                        if $0.roomId == items[index].roomId {
                            items[index].isSelect = true
                        } else {
                            items[index].isSelect = false
                        }
                    }
                    return items
                }
                .bind(to: viewModel.seminarList)
                .disposed(by: disposeBag)

            pageData
                .map { $0.isSecret }
                .bind(to: viewModel.isOn)
                .disposed(by: disposeBag)

            /*
             Scroll...
             */

        }
    }

    private func endEditing(view: UIView, disposeBag: DisposeBag) {
        view.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}

extension CreateSeminarRoomViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCnt
    }

    // swiftlint:disable cyclomatic_complexity
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CreateRoomInputTableViewCell.self),
                for: indexPath) as? CreateRoomInputTableViewCell else { return UITableViewCell() }
            endEditing(view: cell.backView, disposeBag: cell.disposeBag)
            cell.configure(title: localizable.createSeminarTitle(),
                           plachold: localizable.createSeminarInsertTitle(),
                           text: viewModel.title.value ?? "")

            cell.textFeild.rx.text.orEmpty
                .map { $0.count <= 80 ? $0 : String($0.prefix(80)) }
                .bind(onNext: { [weak self] in
                    self?.viewModel.title.accept($0)
                    cell.configure(title: localizable.createSeminarTitle(),
                                   plachold: localizable.createSeminarInsertTitle(),
                                   text: $0)
                })
                .disposed(by: cell.disposeBag)
            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CreateRoomInputTableViewCell.self),
                for: indexPath) as? CreateRoomInputTableViewCell else { return UITableViewCell() }
            endEditing(view: cell.backView, disposeBag: cell.disposeBag)
            cell.configure(title: localizable.createSeminarDesc(),
                           plachold: localizable.createSeminarInsertDesc(),
                           text: viewModel.craeteDescription.value ?? "",
                           decorationStr: localizable.createSeminarOption(),
                           decorationColor: UIColor("#0066FF"))

            cell.textFeild.rx.text.orEmpty
                .map { $0.count <= 200 ? $0 : String($0.prefix(200)) }
                .bind { [weak self] in
                    self?.viewModel.craeteDescription.accept($0)
                    cell.configure(title: localizable.createSeminarDesc(),
                                   plachold: localizable.createSeminarInsertDesc(),
                                   text: $0,
                                   decorationStr: localizable.createSeminarOption(),
                                   decorationColor: UIColor("#0066FF"))
                }
                .disposed(by: cell.disposeBag)
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CreateRoomFixTableViewCell.self),
                for: indexPath) as? CreateRoomFixTableViewCell else { return UITableViewCell() }
            endEditing(view: cell.backView, disposeBag: cell.disposeBag)
            repository.member
                .map { $0.profileName }
                .bind(to: cell.fixLabel.rx.text)
                .disposed(by: cell.disposeBag)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CreateRoomURLPathTableViewCell.self),
                for: indexPath) as? CreateRoomURLPathTableViewCell else { return UITableViewCell() }
            endEditing(view: cell.backView, disposeBag: cell.disposeBag)
            cell.configure(viewModel.urlPath.value)
            cell.urlTextFeild.rx.text
                .bind(to: viewModel.urlPath)
                .disposed(by: cell.disposeBag)
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CreateRoomScheduleTableViewCell.self),
                for: indexPath) as? CreateRoomScheduleTableViewCell else { return UITableViewCell() }
            endEditing(view: cell.backView, disposeBag: cell.disposeBag)
            cell.configure(startDate: viewModel.startDate.value, endDate: viewModel.endDate.value)

            cell.startDateButton.rx.baseTapGesture()
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.showDatePicker(datePickerMode: .dateAndTime, selectedDate: Date()) { _, selectedDate, _ in
                        let selectDate = (selectedDate as? Date) ?? Date()
                        if selectDate > Date() - 1.days {
                            self.viewModel.startDate.accept(selectDate)
                            self.viewModel.endDate.accept(selectDate)
                            cell.configure(startDate: selectDate)
                            cell.configure(endDate: selectDate)
                        } else {
                            CommonModal.Builder()
                                .setMessage(localizable.createSeminarTodayInvalidMessage())
                                .setPositiveButton(localizable.createSeminarInvalidConformMessage()) {
                                    $0.dismiss(animated: true)
                                }
                                .build()
                                .show()
                        }
                    }
                })
                .disposed(by: cell.disposeBag)

            cell.startTimeButton.rx.baseTapGesture()
                .bind(onNext: { [weak self] in
                    guard let self else { return }
                    self.showDatePicker(datePickerMode: .dateAndTime, selectedDate: viewModel.startDate.value ?? Date(), { _, selectedDate, _ in
                        let selectDate = (selectedDate as? Date) ?? Date()
                        if selectDate < self.viewModel.endDate.value ?? Date() {
                            self.viewModel.startDate.accept(selectDate)
                            cell.configure(startDate: selectDate)
                        } else {
                            CommonModal.Builder()
                                .setMessage(localizable.createSeminarStartTimeInvalidMessage())
                                .setPositiveButton(localizable.createSeminarInvalidConformMessage()) {
                                    $0.dismiss(animated: true)
                                }
                                .build()
                                .show()
                        }
                    })
                })
                .disposed(by: cell.disposeBag)

            cell.endTimeButton.rx.baseTapGesture()
                .bind(onNext: { [weak self] in
                    guard let self else { return }
                    /*
                     let datePicker = ActionSheetDatePicker(
                         title: "",
                         datePickerMode: .time,
                         selectedDate: (self.viewModel.startDate.value ?? Date()),
                         doneBlock: { _, selectedDate, _ in
                             let selectDate = (selectedDate as? Date) ?? Date()

                             self.viewModel.endDate.accept(selectDate)
                             cell.configure(endDate: selectDate)
                         },
                         cancel: { _ in
                         },
                         origin: self.view
                     )
                     */
                    let selectedDate = self.viewModel.startDate.value ?? Date()
                    self.showDatePicker(datePickerMode: .time,
                                        selectedDate: selectedDate) { _, selectedDate, _ in
                        let selectDate = (selectedDate as? Date) ?? Date()
                        if self.viewModel.startDate.value ?? Date() < selectDate {
                            self.viewModel.endDate.accept(selectDate)
                            cell.configure(endDate: selectDate)
                        } else {
                            CommonModal.Builder()
                                .setMessage(localizable.createSeminarEndTimeInvalidMessage())
                                .setPositiveButton(localizable.createSeminarInvalidConformMessage()) {
                                    $0.dismiss(animated: true)
                                }
                                .build()
                                .show()
                        }

                    }
                })
                .disposed(by: cell.disposeBag)
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CreateRoomOtherSettingTableViewCell.self),
                for: indexPath) as? CreateRoomOtherSettingTableViewCell else { return UITableViewCell() }
            endEditing(view: cell.backView, disposeBag: cell.disposeBag)
            cell.configure(viewModel.isOn.value)
            cell.onOffSwitch.rx.isOn
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    if !$0 {
                        self.viewModel.password.accept("")
                    }
                    self.viewModel.isOn.accept($0)
                })
                .disposed(by: cell.disposeBag)
            cell.onOffSwitch.rx.baseTapGesture()
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    if !self.viewModel.isOn.value {
                        let viewModel = SeminarPwModalViewModel(hidePasswordConfirm: false)
                        let modal = SeminarPwModal(viewModel: viewModel)
                        modal.setCompleteDelegate {
                            if $0?.isEmpty == true {
                                self.viewModel.isOn.accept(false)
                                cell.configure(false, animation: true)
                            } else {
                                self.viewModel.password.accept($0)
                            }
                        }
                        self.presentPanmodal(panModel: modal, backgroundColor: .togetherWhite)
                    }
                })
                .disposed(by: cell.disposeBag)
            return cell

        case 6:
            seminarRoomSelectTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CreateRoomSelectSeminarRoomSelectTableViewCell.self),
                for: indexPath) as? CreateRoomSelectSeminarRoomSelectTableViewCell

            guard let cell = seminarRoomSelectTableViewCell else { return UITableViewCell() }

            let tag = viewModel.roomTag.value
            let list = viewModel.seminarList.value
            let seminarCnt = viewModel.seminarCnt.value
            cell.register(delegate: self)

            cell.configure(isCreate: viewModel.id == CreateSeminarRoomViewModel.NEW,
                           tag: tag,
                           list: list,
                           seminarCtn: seminarCnt)

            cell.allButton.rx.baseTapGesture()
                .bind { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.seminarCnt.accept(0)
                    self.viewModel.roomTag.accept(0)
                    self.tableView.reloadData()
                }
                .disposed(by: cell.disposeBag)

            cell.smallButton.rx.baseTapGesture()
                .bind { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.seminarCnt.accept(0)
                    self.viewModel.roomTag.accept(1)
                    self.tableView.reloadData()
                }
                .disposed(by: cell.disposeBag)

            cell.middleButton.rx.baseTapGesture()
                .bind { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.seminarCnt.accept(0)
                    self.viewModel.roomTag.accept(2)
                    self.tableView.reloadData()
                }
                .disposed(by: cell.disposeBag)

            cell.bigButton.rx.baseTapGesture()
                .bind { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.seminarCnt.accept(0)
                    self.viewModel.roomTag.accept(3)
                    self.tableView.reloadData()
                }
                .disposed(by: cell.disposeBag)

            cell.pageControl.currentPage = seminarRoomCurrentPage

            cell.cntDownButton.rx.baseTapGesture()
                .filter { [weak self] in
                    guard let self else { return false }
                    let list = self.viewModel.seminarList.value.filter {
                        $0.isSelect
                    }
                    return list.isEmpty
                }
                .filter {
                    seminarCnt == 0
                }
                .bind(onNext: {
                    CommonModal.Builder()
                        .setMessage(localizable.createSeminarSelectSeminar())
                        .setPositiveButton(localizable.createSeminarConfirm()) {
                            $0.dismiss(animated: true)
                        }
                        .build()
                        .show()
                })
                .disposed(by: cell.disposeBag)

            cell.cntUpButton.rx.baseTapGesture()
                .filter { [weak self] in
                    guard let self else { return false }
                    let list = self.viewModel.seminarList.value.filter {
                        $0.isSelect
                    }
                    return list.isEmpty
                }
                .filter { seminarCnt == 0 }
                .bind(onNext: {
                    CommonModal.Builder()
                        .setMessage(localizable.createSeminarSelectSeminar())
                        .setPositiveButton(localizable.createSeminarConfirm()) {
                            $0.dismiss(animated: true)
                        }
                        .build()
                        .show()
                })
                .disposed(by: cell.disposeBag)

            cell.cntDownButton.rx.baseTapGesture()
                .filter { seminarCnt > 0 }
                .map { [weak self] _ -> Int in
                    guard let self = self else { return 0 }
                    return self.viewModel.seminarCnt.value - 1
                }
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.seminarCnt.accept($0)
                    self.tableView.reloadData()
                })
                .disposed(by: cell.disposeBag)

            cell.cntUpButton.rx.baseTapGesture()
                .filter { _ in
                    cell.getPeopleCnt() != 0
                }
                .filter {
                    if seminarCnt > 0 {
                        return cell.getAllCnt() < 200
                    } else {
                        return true
                    }
                }
                .map { [weak self] _ -> Int in
                    guard let self = self else { return 0 }
                    return self.viewModel.seminarCnt.value + 1
                }
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.seminarCnt.accept($0)
                    self.tableView.reloadData()
                })
                .disposed(by: cell.disposeBag)

            return cell

        default:
            return UITableViewCell()
        }
    }

    private func showDatePicker(datePickerMode: UIDatePicker.Mode,
                                selectedDate: Date,
                                _ doneBlock: @escaping ActionDateDoneBlock) {
        view.endEditing(true)
        let datePicker = ActionSheetDatePicker(title: nil,
                                               datePickerMode: datePickerMode,
                                               selectedDate: selectedDate,
                                               doneBlock: doneBlock,
                                               cancel: nil,
                                               origin: view)
        datePicker?.tapDismissAction = .success
        datePicker?.hideCancel = true
        datePicker?.setDoneButton(UIBarButtonItem(title: "확인", style: .plain, target: nil, action: nil))
        datePicker?.locale = Locale(identifier: AppConfigure.local)
        datePicker?.show()
    }
}

extension CreateSeminarRoomViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.seminarList.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CreateRoomSelectSeminarItemCollectionViewCell.self),
            for: indexPath) as? CreateRoomSelectSeminarItemCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(viewModel.seminarList.value[indexPath.row])
        cell.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }

                /*
                 세미나 카운트 업데이트
                 */
                self.viewModel.seminarCnt.accept(0)

                /*
                 update
                 */
                var list = self.viewModel.seminarList.value
                for index in 0..<list.count {
                    list[index].isSelect = false
                }

                list[indexPath.row].isSelect = true
                self.viewModel.seminarList.accept(list)
            })
            .disposed(by: cell.disposBag)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        self.seminarRoomSelectTableViewCell?.pageControl.currentPage = indexPath.row
        self.seminarRoomCurrentPage = indexPath.row
    }
}
