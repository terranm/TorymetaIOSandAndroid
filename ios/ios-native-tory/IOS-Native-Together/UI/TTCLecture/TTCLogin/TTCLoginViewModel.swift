//
//  TTCLoginViewModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import Foundation
import RxSwift
import RxCocoa

final class TTCLoginViewModel: RefactoringBaseViewModel {

    private(set) var ttcAuthRelay = BehaviorRelay<Bool>(value: false)
    private let repository = WDRepository.shared
    enum LoginStatus: Comparable {
        case cancel
        case failure(message: String)
        case unauthorized
        case authorized
    }
    private(set) var loginStatusRelay = BehaviorRelay<LoginStatus>(value: .unauthorized)

    struct LoginInfo {
        let email: String?
        let password: String?
    }
    private(set) var loginInfo: LoginInfo?

    struct UniversityInfo {
        let name: String
        let imageURL: URL?
        let major: String
    }
    var universityInfo: UniversityInfo? {
        let universityCode = repository.initData.value.memberVO.universityCode
        guard let university = repository.initData.value.universityVOList
            .filter({ $0.universityCode == universityCode }).first else { return nil }
        return UniversityInfo(name: university.universityName,
                              imageURL: URL(string: university.imgUrl),
                              major: university.logoName)
    }

    func checkValidLoginInfo(_ email: String?, _ password: String?) {
        guard let email, let password else { return }
        ttcAuthRelay.accept(!email.isEmpty && !password.isEmpty)
        loginInfo = LoginInfo(email: email, password: password)
    }

    func tryLogin() {
        guard let email = loginInfo?.email, let password = loginInfo?.password else { return }
        repository.requestTTCLogin(userId: email, password: password)
            .bind { [weak self] isLoggedIn in
                guard isLoggedIn else { return }
                self?.loginStatusRelay.accept(.authorized)
                self?.repository.isTTCLoggedIn.accept(true)
            }
            .disposed(by: disposeBag)
    }
}
