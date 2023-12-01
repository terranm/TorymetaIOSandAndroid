//
//  BoardSelectViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/20.
//

import Foundation
import RxSwift
import RxCocoa

final class BoardSelectViewModel: RefactoringBaseViewModel {

    func getCampusImageURL() -> Driver<String> {
        repository.getMyCampus()
            .map { $0.imgUrl}
            .asDriver(onErrorDriveWith: .empty())
    }

    func getBoardList() -> Driver<[BoardSelectDto]> {
        Driver.just([
            BoardSelectDto(assetName: R.image.board_Market.name,
                           name: localizable.boardSelectToryMarket(),
                           webViewUrl: "board/community/4"),
            BoardSelectDto(assetName: R.image.board_we.name,
                           name: localizable.boardSelectWe(),
                           webViewUrl: "board/community/2"),
            BoardSelectDto(assetName: R.image.board_Talk.name,
                           name: localizable.boardSelectTalk(),
                           webViewUrl: "board/community/1"),
            BoardSelectDto(assetName: R.image.board_help.name,
                           name: localizable.boardSelectHelp(),
                           webViewUrl: "board/community/3")
        ])
    }
}
