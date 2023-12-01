//
//  BoardRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa

extension BoardRepositoryProtocol {
    /*
     내가 쓴글 리스트
     */
    func getMyWriteList() -> Observable<[MyWriteListResultDto.Item]> {
        boardAPI.getMyWriteList()
            .map { $0.list }
    }
    /*
     내가 쓴 댓글 리스트
     */
    func getMyCommentList() -> Observable<[MyCommentListResultDto.Item]> {
        boardAPI.getMyCommentList()
            .map { $0.list }
    }
}
