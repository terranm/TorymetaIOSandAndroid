//
//  TTCAPIResult.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/18.
//

import Foundation

struct TTCLectureList: Codable {
    let lectureList: [Lecture]
    let offset: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lectureList = try container.decode([TTCLectureList.Lecture].self, forKey: .lectureList)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset) ?? 0
    }

    struct Lecture: Codable {
        let num: Int
        let start: String
        let end: String
        let cat: String
        let subject: String
        var totalProcess: Int
        let link: String
        let wrId: Int
        let lecId: Int
        let clLecSub: String

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<TTCLectureList.Lecture.CodingKeys> =
                try decoder.container(keyedBy: TTCLectureList.Lecture.CodingKeys.self)
            self.num = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureList.Lecture.CodingKeys.num) ?? 0
            self.start = try container
                .decodeIfPresent(String.self, forKey: TTCLectureList.Lecture.CodingKeys.start) ?? ""
            self.end = try container
                .decodeIfPresent(String.self, forKey: TTCLectureList.Lecture.CodingKeys.end) ?? ""
            self.cat = try container
                .decodeIfPresent(String.self, forKey: TTCLectureList.Lecture.CodingKeys.cat) ?? ""
            self.subject = try container
                .decodeIfPresent(String.self, forKey: TTCLectureList.Lecture.CodingKeys.subject) ?? ""
            self.totalProcess = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureList.Lecture.CodingKeys.totalProcess) ?? 0
            self.link = try container
                .decodeIfPresent(String.self, forKey: TTCLectureList.Lecture.CodingKeys.link) ?? ""
            self.wrId = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureList.Lecture.CodingKeys.wrId) ?? 0
            self.lecId = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureList.Lecture.CodingKeys.lecId) ?? 0
            self.clLecSub = try container
                .decodeIfPresent(String.self, forKey: TTCLectureList.Lecture.CodingKeys.clLecSub) ?? ""
        }
    }
}

struct TTCLectureSubList: Codable {
    let list: [SubLecture]
    let totalProcess: Int
    let lecturePeriod: String
    let guide: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try container.decode([TTCLectureSubList.SubLecture].self, forKey: .list)
        self.totalProcess = try container.decodeIfPresent(Int.self, forKey: .totalProcess) ?? 0
        self.lecturePeriod = try container.decodeIfPresent(String.self, forKey: .lecturePeriod) ?? ""
        self.guide = try container.decodeIfPresent(String.self, forKey: .guide) ?? ""
    }

    struct SubLecture: Codable {
        var isPlaying: Bool = false
        var process: Int
        let period: Int
        let title: String
        let dayLimit: Bool
        let applyId: Int
        let lecId: Int
        let wrOrder: Int

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<TTCLectureSubList.SubLecture.CodingKeys> =
                try decoder.container(keyedBy: TTCLectureSubList.SubLecture.CodingKeys.self)
            self.process = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureSubList.SubLecture.CodingKeys.process) ?? 0
            self.period = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureSubList.SubLecture.CodingKeys.period) ?? 0
            self.title = try container
                .decodeIfPresent(String.self, forKey: TTCLectureSubList.SubLecture.CodingKeys.title) ?? ""
            self.dayLimit = try container
                .decodeIfPresent(Bool.self, forKey: TTCLectureSubList.SubLecture.CodingKeys.dayLimit) ?? false
            self.applyId = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureSubList.SubLecture.CodingKeys.applyId) ?? 0
            self.lecId = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureSubList.SubLecture.CodingKeys.lecId) ?? 0
            self.wrOrder = try container
                .decodeIfPresent(Int.self, forKey: TTCLectureSubList.SubLecture.CodingKeys.wrOrder) ?? 0
        }
    }
}

struct TTCLecturePlayerInformation: Codable {
    let headerTitle: String
    let contentUrl: String
    let applyId: Int
    let lecId: Int
    let curpos: Double
    let wrOrder: Int
    let lmsTimeId: Int
    let isStudied: Bool
    let endCk: String
    let time: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.headerTitle = try container.decodeIfPresent(String.self, forKey: .headerTitle) ?? ""
        self.contentUrl = try container.decodeIfPresent(String.self, forKey: .contentUrl)?
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        self.applyId = try container.decodeIfPresent(Int.self, forKey: .applyId) ?? 0
        self.lecId = try container.decodeIfPresent(Int.self, forKey: .lecId) ?? 0
        self.curpos = try container.decodeIfPresent(Double.self, forKey: .curpos) ?? 0
        self.wrOrder = try container.decodeIfPresent(Int.self, forKey: .wrOrder) ?? 0
        self.lmsTimeId = try container.decodeIfPresent(Int.self, forKey: .lmsTimeId) ?? 0
        self.isStudied = try container.decodeIfPresent(Bool.self, forKey: .isStudied) ?? false
        self.endCk = try container.decodeIfPresent(String.self, forKey: .endCk) ?? ""
        self.time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
    }
}
