//
//  CommonRESTfullAPIService.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/05.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

// 한건의 Request를 담당
// *** API Request 추상화
struct CommonRESTfulAPIService<Wrapper: APIWrapperProtocol>: AppStorageProtocol {
    private let requestContext: APIRequestContextProtocol
    init(requestContext: APIRequestContextProtocol) {
        self.requestContext = requestContext
    }

    func getMapping() -> Observable<Wrapper.Data> {
        request(method: .get, encoding: URLEncoding.default)
    }

    func postMapping() -> Observable<Wrapper.Data> {
        request(method: .post, encoding: JSONEncoding.default)
    }

    func deleteMapping() -> Observable<Wrapper.Data> {
        request(method: .delete, encoding: URLEncoding.default)
    }

    func putMappding() -> Observable<Wrapper.Data> {
        request(method: .put, encoding: JSONEncoding.default)
    }

    func patchMappding() -> Observable<Wrapper.Data> {
        request(method: .patch, encoding: JSONEncoding.default)
    }

    func multipartFormMapping() -> Observable<Wrapper.Data> {
        request()
    }

    private func request(method: HTTPMethod, encoding: ParameterEncoding) -> Observable<Wrapper.Data> {
        let subject = PublishSubject<Wrapper.Data>()

        _ = subject
            .take(1)
            .subscribe()

        let responseData = responseData(method: method, encoding: encoding)
        _ = requestTransaction(responseData: responseData)
            .subscribe(subject)

        return subject
    }

    private func request() -> Observable<Wrapper.Data> {
        let subject = PublishSubject<Wrapper.Data>()

        _ = subject
            .take(1)
            .subscribe()

        let responseData = responseData()
        _ = requestTransaction(responseData: responseData)
            .subscribe(subject)

        return subject
    }

    private func requestTransaction(responseData: Observable<(HTTPURLResponse, Data)>) -> Observable<Wrapper.Data> {
        var introView: IntroViewProtocol?
        return responseData
            .do(onSubscribe: { [self] in
                switch self.requestContext.requestUIMode {
                case .blur:
                    introView = CommonBlurView()
                case .loading:
                    introView = CommonLoadingView()
                }
                introView?.show()
            }).catch { [self] error in
                introView?.dismiss()
                introView = nil
                throw self.resultUnknownError(error: error)
            }
            .map { [self] in
                introView?.dismiss()
                introView = nil
                do {
                    return try self.result(statusCode: $0.0.statusCode, data: $0.1)
                } catch {
                    throw error
                }
            }
    }

    private func responseData(method: HTTPMethod, encoding: ParameterEncoding) -> Observable<(HTTPURLResponse, Data)> {
        AF.request(requestContext.requestURL,
                   method: method,
                   parameters: requestContext.params,
                   encoding: encoding,
                   headers: requestContext.headers)
        .rx.responseData()
    }

    private func responseData() -> Observable<(HTTPURLResponse, Data)> {
        AF.upload(multipartFormData: { multipartFormData in
            requestContext.multipartFormDatas.forEach { multipartForm in
                multipartFormData.append(multipartForm.data,
                                         withName: multipartForm.withName,
                                         fileName: multipartForm.fileName,
                                         mimeType: multipartForm.mimeType)
            }
        }, to: requestContext.requestURL,
                  method: .post,
                  headers: requestContext.headers)
        .rx.responseData()
    }

    private func result(statusCode: Int, data: Data) throws -> Wrapper.Data {
        // MARK: ResponseUIMode 처리
        let api = try? JSONDecoder().decode(Wrapper.self, from: data)
        if let api = api,
           let apiData = (200..<300 ~= statusCode && api.resultCode == requestContext.resultCode) ? api.result : nil {
            return apiData
        }
        if let api = api,
           200..<300 ~= statusCode && api.resultCode == requestContext.resultCode && api.result == nil {
            throw resultDataIsNull(statusCode: statusCode, api: api)
        }
        if let api = api,
           200..<300 ~= statusCode && api.resultCode != requestContext.resultCode {
            throw resultCodeIsNotSuccess(statusCode: statusCode, api: api)
        }
        if statusCode == 403 {
            throw athorizationIsNotInvalid(statusCode: statusCode)
        }
        if 400..<500 ~= statusCode {
            throw clientError(statusCode: statusCode)
        }
        if let api = api,
           500..<600 ~= statusCode {
            throw serverError(statusCode: statusCode, api: api)
        }
        if api == nil {
            throw jsonParsingError(statusCode: statusCode)
        }
        throw resultUnknownError(statusCode: statusCode)
    }

    private func requestUnknownError(error: Error) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0001)
        let errorInfo = errorInformation(requestURL: requestContext.requestURL,
                                         errorMessage: error.localizedDescription)
        errorMessagePrint(message: "🚨 \(requestContext.serverName) - request unknown error:\(errorInfo)")
        return error
    }

    private func resultDataIsNull(statusCode: Int, api: Wrapper) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0002)
        let errorInfo = errorInformation( statusCode: statusCode, requestURL: requestContext.requestURL,
                                          resultCode: api.resultCode, resultMessage: api.resultMessage)
        errorMessagePrint(message: "🚨 \(requestContext.serverName) - result data is null: \(errorInfo)")
        return NetworkError.resultDataIsNull(api.resultCode, api.resultMessage)
    }

    private func resultCodeIsNotSuccess(statusCode: Int, api: Wrapper) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0003)
        let errorInfo = errorInformation(statusCode: statusCode, requestURL: requestContext.requestURL,
                                         resultCode: api.resultCode, resultMessage: api.resultMessage)
        errorMessagePrint(message: "🚨 \(requestContext.serverName) - resultCode is not success:\(errorInfo)")
        return NetworkError.serverError(api.resultCode, api.resultMessage)
    }

    private func athorizationIsNotInvalid(statusCode: Int) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0004)
        let errorInfo = errorInformation(statusCode: statusCode, requestURL: requestContext.requestURL)
        let message = "🚨 \(requestContext.serverName) - athorization error:\(errorInfo)"
        errorMessagePrint(message: message)
        return NetworkError.authorizationError(message)
    }

    private func serverError(statusCode: Int, api: Wrapper) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0005)
        let errorInfo = errorInformation(statusCode: statusCode, requestURL: requestContext.requestURL,
                                         resultCode: api.resultCode, resultMessage: api.resultMessage)
        let message = "🚨 \(requestContext.serverName) - server error:\(errorInfo)"
        errorMessagePrint(message: message)
        return NetworkError.clientError(message)
    }

    private func clientError(statusCode: Int) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0006)
        let errorInfo = errorInformation(statusCode: statusCode, requestURL: requestContext.requestURL)
        let message = "🚨 \(requestContext.serverName) - client error:\(errorInfo)"
        errorMessagePrint(message: message)
        return NetworkError.clientError(message)
    }

    private func jsonParsingError(statusCode: Int) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0007)
        let errorInfo = errorInformation(statusCode: statusCode, requestURL: requestContext.requestURL)
        let message = "🚨 \(requestContext.serverName) - json parsing error:\(errorInfo)"
        errorMessagePrint(message: message)
        return NetworkError.jsonParsingError(message)
    }

    private func resultUnknownError(statusCode: Int) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0008)
        let errorInfo = errorInformation(statusCode: statusCode, requestURL: requestContext.requestURL)
        let message = "🚨 \(requestContext.serverName) - result unknownError error:\(errorInfo)"
        errorMessagePrint(message: message)
        return NetworkError.unkownError(message)
    }

    private func resultUnknownError(error: Error) -> Error {
        respondToErrorsWithUI(errorCodeShownInClient: 0009)
        let errorInfo = errorInformation(statusCode: 8888, requestURL: requestContext.requestURL)
        let message = "🚨 \(requestContext.serverName) - result unknownError error:\(errorInfo)"
        errorMessagePrint(message: message)
        return error
    }

    private func respondToErrorsWithUI(errorCodeShownInClient: Int) {
        let message = localizable.commonAPITemporaryError("\(errorCodeShownInClient)")
        switch requestContext.resultUIMode {
        case .showWarning:
            CommonModal.Builder()
                .setMessage(message)
                .setPositiveButton(localizable.commonAPIConfirm()) { $0.dismiss(animated: true) }
                .build()
                .show()
        case .showToast:
            CommonToast.Builder()
                .setMessage(message)
                .build()
                .show()
        case .showRetryView:
            // DepthView가 RetryEnabledProtocol을 상속 받아야 한다.
//            let host = depthViewController as? RetryEnabledProtocol
//            CommonRetryView.Builder()
//                .setTitle("")
//                .setButtonText("")
//                .build(host: host)
//                .show()
            break
        case .showRestart:
            CommonModal.Builder()
                .setMessage(message)
                .setPositiveButton(localizable.commonAPIRetry()) {
                    $0.dismiss(animated: true)
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                }
                .build()
                .show()
        case .translateLogin:
            /*
             사용자 정보 초기화
             */
            UserDefaults.standard.setValue("", forKey: "token")
            UserDefaults.standard.setValue(false, forKey: "isAutoLogin")
            UserDefaults.standard.setValue(0, forKey: "memberId")
            /*
             Login page로 전환
             */
            let url = ToryWebViewURL(path: ToryWebViewURLType.login.path)
            let commonWebViewModel = CommonWebViewModel()
            let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: commonWebViewModel)

            commonWebViewController.view.backgroundColor = .togetherWhite
            commonWebViewController.modalTransitionStyle = .crossDissolve
            commonWebViewController.modalPresentationStyle = .fullScreen

            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController
            = commonWebViewController
            window?.makeKeyAndVisible()
        case .validation: break
        }
    }

    private func errorMessagePrint(message: String) {
#if DEBUG
        print(message)
#endif
    }

    private func errorInformation(
        statusCode: Int? = nil,
        requestURL: String? = nil,
        errorMessage: String? = nil,
        resultCode: String? = nil,
        resultMessage: String? = nil
    ) -> String {
        var result = "["
        if let statusCode = statusCode {
            result += "statusCode: \(statusCode), "
        }
        if let requestURL = requestURL {
            result += "requestURL: \(requestURL), "
        }
        if let errorMessage = errorMessage {
            result += "errorMessage: \(errorMessage), "
        }
        if let resultCode = resultCode {
            result += "resultCode: \(resultCode), "
        }
        if let resultMessage = resultMessage {
            result += "resultMessage: \(resultMessage), "
        }
        if result.hasSuffix(", ") {
            result.removeLast(2)
        }
        result += "]"
        return result
    }
}
