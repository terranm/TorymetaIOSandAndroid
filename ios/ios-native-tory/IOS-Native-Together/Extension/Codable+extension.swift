//
//  Codable+extension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation

extension Encodable {
    func convertToDict() -> [String: Any]? {
        var dict: [String: Any]?
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        } catch {
            print(error)
        }
        return dict
    }
}
