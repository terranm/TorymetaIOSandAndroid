//
//  ChattingLoungePasswordViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation

final class ChattingLoungePasswordViewModel: RefactoringBaseViewModel {
    let password: String?
    let isBackgroundClear: Bool

    init(password: String?, isBackgroundClear: Bool) {
        self.password = password
        self.isBackgroundClear = isBackgroundClear
        super.init()
    }
}
