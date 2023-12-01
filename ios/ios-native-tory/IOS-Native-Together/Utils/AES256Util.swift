//
//  AES256Util.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/06.
//
import Foundation
import CryptoSwift

final class AES256Util {
    private var secretKey: String { "b0b5a4b9a31e5ba2aee85ff1d6c255gg" }
    private var initialValue: String {
        let startIndex = secretKey.index(secretKey.startIndex, offsetBy: 0)
        let endIndex = secretKey.index(secretKey.startIndex, offsetBy: 15)
        let reseult = String(secretKey[startIndex...endIndex])
        return reseult
    }

    func encrypt(string: String) -> String? {
        guard !string.isEmpty else { return nil }
        return try? getAESObject()?.encrypt(string.bytes).toBase64()
    }

    func decrypt(encoded: String) -> String? {
        let datas = Data(base64Encoded: encoded)
        guard let bytes = datas?.bytes else { return nil }
        guard let decode = try? getAESObject()?.decrypt(bytes) else { return nil }
        return String(bytes: decode, encoding: .utf8)
    }

    func getAESObject() -> AES? {
        let keyDecodes = Array(secretKey.utf8)
        let initialValueDecodes = Array(initialValue.utf8)
        let aesObject = try? AES(key: keyDecodes, blockMode: CBC(iv: initialValueDecodes), padding: .pkcs5)

        return aesObject
    }
}
