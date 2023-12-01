//
//  BoardDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/29.
//

import Foundation

/*
 게시판 타입
 */
enum BoardType: String {
    case TALK    = "community"
    case MEETING = "meeting"
    case HELP    = "errand"
    case MARKET  = "market"
}

/*
 마이페이지 내가 쓴 글 리스트 결과
 */
struct MyCommentListResultDto: Codable {
    let list: [Item]

    struct Item: Codable {
        let bbsId: Int
        let schCd: String
        private let bbsType: Int
        var boardType: BoardType {
            switch bbsType {
            case 1: return BoardType.TALK
            case 2: return BoardType.MEETING
            case 3: return BoardType.HELP
            case 4: return BoardType.MARKET
            default: return BoardType.TALK
            }
        }
        let cmntSeq: Int
        let cmntRplySeq: Int
        let comment: String
        private let reportyn: String
        var isReport: Bool {
            switch reportyn {
            case "Y": return true
            case "N": return false
            default: return false
            }
        }
        let memberId: Int
        let profileName: String
        let imgUrl: String
        let regDt: String

        init() {
            self.bbsId = 0
            self.schCd = ""
            self.bbsType = 0
            self.cmntSeq = 0
            self.cmntRplySeq = 0
            self.comment = ""
            self.reportyn = "N"
            self.memberId = 0
            self.profileName = ""
            self.imgUrl = ""
            self.regDt = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<MyCommentListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: MyCommentListResultDto.Item.CodingKeys.self)
            self.bbsId = try container
                .decodeIfPresent(Int.self, forKey: MyCommentListResultDto.Item.CodingKeys.bbsId) ?? 0
            self.schCd = try container
                .decodeIfPresent(String.self, forKey: MyCommentListResultDto.Item.CodingKeys.schCd) ?? ""
            self.bbsType = try container
                .decodeIfPresent(Int.self, forKey: MyCommentListResultDto.Item.CodingKeys.bbsType) ?? 0
            self.cmntSeq = try container
                .decodeIfPresent(Int.self, forKey: MyCommentListResultDto.Item.CodingKeys.cmntSeq) ?? 0
            self.cmntRplySeq = try container
                .decodeIfPresent(Int.self, forKey: MyCommentListResultDto.Item.CodingKeys.cmntRplySeq) ?? 0
            self.comment = try container
                .decodeIfPresent(String.self, forKey: MyCommentListResultDto.Item.CodingKeys.comment) ?? ""
            self.reportyn = try container
                .decodeIfPresent(String.self, forKey: MyCommentListResultDto.Item.CodingKeys.reportyn) ?? "N"
            self.memberId = try container
                .decodeIfPresent(Int.self, forKey: MyCommentListResultDto.Item.CodingKeys.memberId) ?? 0
            self.profileName = try container
                .decodeIfPresent(String.self, forKey: MyCommentListResultDto.Item.CodingKeys.profileName) ?? ""
            self.imgUrl = try container
                .decodeIfPresent(String.self, forKey: MyCommentListResultDto.Item.CodingKeys.imgUrl) ?? ""
            self.regDt = try container
                .decodeIfPresent(String.self, forKey: MyCommentListResultDto.Item.CodingKeys.regDt) ?? ""
        }

        enum CodingKeys: String, CodingKey {
            case bbsId = "bbs_id"
            case schCd = "sch_cd"
            case bbsType = "bbs_type"
            case cmntSeq = "cmnt_seq"
            case cmntRplySeq = "cmnt_rply_seq"
            case comment = "comment"
            case reportyn = "reportyn"
            case memberId = "member_id"
            case profileName = "profile_name"
            case imgUrl = "img_url"
            case regDt = "reg_dt"
        }
    }

    enum CodingKeys: String, CodingKey {
        case list = "lists"
    }
}

/*
 마이페이지 내가 쓴 댓글 리스트 결과
 */

struct MyWriteListResultDto: Codable {
    let list: [Item]

    struct Item: Codable {
        let bbsId: Int
        let schCd: String
        private let bbsType: Int
        var boardType: BoardType {
            switch bbsType {
            case 1: return BoardType.TALK
            case 2: return BoardType.MEETING
            case 3: return BoardType.HELP
            case 4: return BoardType.MARKET
            default: return BoardType.TALK
            }
        }

        private let noticeYn: String?
        var isNotice: Bool {
            switch noticeYn {
            case "Y": return true
            case "N": return false
            default: return false
            }
        }
        let topic: Int
        let bbsTitle: String
        let bbsContent: String
        let price: String
        let bbsViewcount: Int
        let cmntCount: Int
        let memberId: Int
        let profileName: String
        let imgUrl: String
        let regDt: String

        init() {
            self.bbsId = 0
            self.schCd = ""
            self.bbsType = 0
            self.noticeYn = ""
            self.topic = 0
            self.bbsTitle = ""
            self.bbsContent = ""
            self.price = ""
            self.bbsViewcount = 0
            self.cmntCount = 0
            self.memberId = 0
            self.profileName = ""
            self.imgUrl = ""
            self.regDt = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<MyWriteListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: MyWriteListResultDto.Item.CodingKeys.self)
            self.bbsId = try container
                .decodeIfPresent(Int.self, forKey: MyWriteListResultDto.Item.CodingKeys.bbsId) ?? 0
            self.schCd = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.schCd) ?? ""
            self.bbsType = try container
                .decodeIfPresent(Int.self, forKey: MyWriteListResultDto.Item.CodingKeys.bbsType) ?? 0
            self.noticeYn = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.noticeYn) ?? "N"
            self.topic = try container
                .decodeIfPresent(Int.self, forKey: MyWriteListResultDto.Item.CodingKeys.topic) ?? 0
            self.bbsTitle = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.bbsTitle) ?? ""
            self.bbsContent = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.bbsContent) ?? ""
            self.price = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.price) ?? ""
            self.bbsViewcount = try container
                .decodeIfPresent(Int.self, forKey: MyWriteListResultDto.Item.CodingKeys.bbsViewcount) ?? 0
            self.cmntCount = try container
                .decodeIfPresent(Int.self, forKey: MyWriteListResultDto.Item.CodingKeys.cmntCount) ?? 0
            self.memberId = try container
                .decodeIfPresent(Int.self, forKey: MyWriteListResultDto.Item.CodingKeys.memberId) ?? 0
            self.profileName = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.profileName) ?? ""
            self.imgUrl = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.imgUrl) ?? ""
            self.regDt = try container
                .decodeIfPresent(String.self, forKey: MyWriteListResultDto.Item.CodingKeys.regDt) ?? ""
        }

        enum CodingKeys: String, CodingKey {
            case bbsId = "bbs_id"
            case schCd = "sch_cd"
            case bbsType = "bbs_type"
            case noticeYn, topic, price
            case bbsTitle = "bbs_title"

            case bbsContent = "bbs_content"
            case bbsViewcount = "bbs_viewcount"
            case cmntCount = "cmnt_count"
            case memberId = "member_id"
            case profileName = "profile_name"
            case imgUrl = "img_url"
            case regDt = "reg_dt"
        }
    }

    enum CodingKeys: String, CodingKey {
        case list = "lists"
    }
}

struct GeneralNoticeListResultDto: Codable {
    let totcnt: Int
    let remain: Int
    let lists: [Item]

    init() {
        self.totcnt = 0
        self.remain = 0
        self.lists = []
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totcnt = try container.decodeIfPresent(Int.self, forKey: .totcnt) ?? 0
        self.remain = try container.decodeIfPresent(Int.self, forKey: .remain) ?? 0
        self.lists = try container.decode([GeneralNoticeListResultDto.Item].self, forKey: .lists)
    }

    struct Item: Codable {
        let bbsType: Int
        let bbsID: Int
        let noticeYN: String
        var isNotice: Bool { noticeYN == "Y" }
        let bbsTitle: String
        let bbsContent: String
        let bbsViewcount: Int
        let regID: String
        let name: String
        let imgURL: String
        let regDate: String
        enum CodingKeys: String, CodingKey {
            case bbsType = "bbs_type"
            case bbsID = "bbs_id"
            case noticeYN = "notice_yn"
            case bbsTitle = "bbs_title"
            case bbsContent = "bbs_content"
            case bbsViewcount = "bbs_viewcount"
            case regID = "reg_id"
            case name = "name"
            case imgURL = "img_url"
            case regDate = "reg_dt"
        }

        init() {
            self.bbsType = 0
            self.bbsID = 0
            self.noticeYN = "Y"
            self.bbsTitle = ""
            self.bbsContent = ""
            self.bbsViewcount = 0
            self.regID = ""
            self.name = ""
            self.imgURL = ""
            self.regDate = ""
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.bbsType = try container.decodeIfPresent(Int.self, forKey: .bbsType) ?? 0
            self.bbsID = try container.decodeIfPresent(Int.self, forKey: .bbsID) ?? 0
            self.noticeYN = try container.decodeIfPresent(String.self, forKey: .noticeYN) ?? "Y"
            self.bbsTitle = try container.decodeIfPresent(String.self, forKey: .bbsTitle) ?? ""
            self.bbsContent = try container.decodeIfPresent(String.self, forKey: .bbsContent) ?? ""
            self.bbsViewcount = try container.decodeIfPresent(Int.self, forKey: .bbsViewcount) ?? 0
            self.regID = try container.decodeIfPresent(String.self, forKey: .regID) ?? ""
            self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            self.imgURL = try container.decodeIfPresent(String.self, forKey: .imgURL) ?? ""
            self.regDate = try container.decodeIfPresent(String.self, forKey: .regDate) ?? ""
        }
    }
}
