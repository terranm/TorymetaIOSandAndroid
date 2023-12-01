//
//  InAppProducts.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/08.
//

import Foundation
import StoreKit

typealias ProductsRequestCompletion = (_ success: Bool, _ products: [SKProduct]?) -> Void

protocol IAPServiceType {
    var canMakePayments: Bool { get }

    func getProducts(completion: @escaping ProductsRequestCompletion)
    func buyProduct(_ product: SKProduct)
    func isProductPurchased(_ productID: String) -> Bool
    func restorePurchases()
    func getReceiptData() -> String?
}

final class IAPService: NSObject, IAPServiceType {

    private let productIDs: Set<String>
    private var purchasedProductIDs: Set<String> = []
    private var productsRequest: SKProductsRequest?
    private var productsCompletion: ProductsRequestCompletion?

    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }

    var loadingView: CommonLoadingView?

    init(productIDs: Set<String>) {
        self.productIDs = productIDs
//        self.purchasedProductIDs = productIDs.filter {
//            UserDefaults.standard.bool(forKey: $0) == true
//        }
        super.init()
        SKPaymentQueue.default().add(self)
    }

    func getProducts(completion: @escaping ProductsRequestCompletion) {
        self.productsRequest?.cancel()
        self.productsCompletion = completion
        self.productsRequest = SKProductsRequest(productIdentifiers: self.productIDs) // 하나만 쏘면....
        self.productsRequest?.delegate = self
        self.productsRequest?.start()
    }

    func buyProduct(_ product: SKProduct) {
        if UIApplication.shared.keyWindow?.rootViewController != nil {
            loadingView = CommonLoadingView()
            loadingView?.show()
        }
        SKPaymentQueue.default().add(SKPayment(product: product))
    }

    func isProductPurchased(_ productID: String) -> Bool {
        self.purchasedProductIDs.contains(productID)
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // 구매이력 영수증 가져오기 - 검증용
    func getReceiptData() -> String? {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                let receiptString = receiptData.base64EncodedString(options: [])
                return receiptString
            } catch {
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                return nil
            }
        }
        return nil
    }
}

extension IAPService: SKProductsRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        self.productsCompletion?(true, products)
        self.clearRequestAndHandler()
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("ERROR: \(error.localizedDescription)")
        self.productsCompletion?(false, nil)
        self.clearRequestAndHandler()
    }

    private func clearRequestAndHandler() {
        self.productsRequest = nil
        self.productsCompletion = nil
    }
}

extension IAPService: SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
          switch $0.transactionState {
          case .purchased:
              loadingView?.dismiss()
              SKPaymentQueue.default().finishTransaction($0)
            self.deliverPurchaseNotificationFor(id: $0.payment.productIdentifier)
              print("completed transaction")

          case .failed:
              loadingView?.dismiss()
            if let transactionError = $0.error as NSError?,
               let description = $0.error?.localizedDescription,
               transactionError.code != SKError.paymentCancelled.rawValue {
              print("Transaction erorr: \(description)")
            }
            SKPaymentQueue.default().finishTransaction($0)
          case .restored:
              loadingView?.dismiss()
            print("failed transaction")
              // 여기다가 API 쏘면 될듯?....
              SKPaymentQueue.default().finishTransaction($0)
              self.deliverPurchaseNotificationFor(id: $0.payment.productIdentifier)
          case .deferred:
              loadingView?.dismiss()
            print("deferred")
          case .purchasing:
            print("purchasing")
          default:
              loadingView?.dismiss()
            print("unknown")
          }
        }
    }

    private func deliverPurchaseNotificationFor(id: String) {
//        guard let id = id else { return }
        self.purchasedProductIDs.insert(id)
        NotificationCenter.default.post(
            name: .iapServicePurchaseNotification,
            object: Int(id.replacingOccurrences(of: "TORY", with: "")) ?? 0
        )
    }
}

enum MyProducts {
    enum Product: String, CaseIterable {
        case tory30   = "30TORY"
        case tory60   = "60TORY"
        case tory120  = "120TORY"
        case tory500  = "500TORY"
        case tory990  = "990TORY"
        case tory1450 = "1450TORY"
    }
    static let iapService: IAPServiceType = IAPService(productIDs: Set(Product.allCases.compactMap({ $0.rawValue })))

    static func getResourceProductName(_ id: String) -> String? {
        id.components(separatedBy: ".").last
    }
}

extension Notification.Name {
    static let iapServicePurchaseNotification = Notification.Name("IAPServicePurchaseNotification")

}
