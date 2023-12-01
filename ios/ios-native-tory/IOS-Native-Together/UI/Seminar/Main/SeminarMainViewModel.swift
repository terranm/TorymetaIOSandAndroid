//
//  SeminarMainViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/18.
//

import Foundation
import RxSwift
import RxCocoa

final class SeminarMainViewModel: RefactoringBaseViewModel {
    let filter = BehaviorRelay<Int>(value: 0)
    let seminarList = BehaviorRelay<[LiveSeminarListResultDto.Item]>(value: [])
}
