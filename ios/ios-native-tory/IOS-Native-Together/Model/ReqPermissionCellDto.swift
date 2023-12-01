//
//  ReqPermissionCellDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/17.
//

import Foundation

struct ReqPermissionCellDto {

    let imgName: String

    let category: String
    let reqOrSelectStr: String

    let isSelect: Bool

    let description: String

    init() {
        self.imgName = ""
        self.category = ""
        self.reqOrSelectStr = ""
        self.isSelect = false
        self.description = ""
    }

    init(imgName: String,
         category: String,
         reqOrSelectStr: String,
         isSelect: Bool,
         description: String) {
        self.imgName = imgName
        self.category = category
        self.reqOrSelectStr = reqOrSelectStr
        self.isSelect = isSelect
        self.description = description
    }
}
