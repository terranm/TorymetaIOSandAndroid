//
//  NetworkError.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

enum NetworkError: Error {
case unkownError(_ errorMessage: String)
case authorizationError(_ errorMessage: String)
case resultDataIsNull(_ resultCode: String?, _ resultMessage: String?)
case serverError(_ resultCode: String?, _ resultMessage: String?)
case jsonParsingError(_ errorMessage: String)
case clientError(_ errorMessage: String)
}
