//
//  CommonDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/29.
//

import Foundation

struct ToryApiResponse<T: Codable>: Codable {
    let resultCode: String?
    let resultMessage: String?
    let result: T?
}

struct NFTAPIResonse<T: Codable>: Codable {
    let resultCode: Int?
    let resultMessage: String?
    let result: T?

    enum CodingKeys: String, CodingKey {
        case resultCode = "code"
        case resultMessage = "message"
        case result = "data"
    }
}
/*
 요청 했을때 결과 값이 없을때
 */
struct EmptyResultDto: Codable {

}

/*
 요청 했을때 Api 결과
 * 토리톡 친구 요청, 수락, 차단, 삭제, 위치 차단, 차단해제
 * 내 위치 lat, lng 업데이트
 * 내 위치 권한 허용 정보 업데이트
 * 대학교 University 업데이트
 */
struct ReqResultDto: Codable {
    private let processYn: String
    var isSuccess: Bool {
        switch processYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.processYn = try container.decodeIfPresent(String.self, forKey: .processYn) ?? "N"
    }
}
