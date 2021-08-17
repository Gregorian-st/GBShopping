//
//  AnalyticsLogging.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 27.07.2021.
//

import Foundation
import Firebase

enum AnalyticsMessageType: String {
    case loginSuccessful = "login_successful"
    case loginUnsuccessful = "login_unsuccessful"
    case logout = "logout"
    case registration = "registration"
    case catalogShow = "catalog_show"
    case productShow = "product_show"
    case productAddToCart = "product_cart_add"
    case productDeleteFromCart = "product_cart_delete"
    case cartPay = "cart_pay"
    case reviewAdd = "review_add"
}

func logAnalytics(messageType: AnalyticsMessageType, messageText: String) {
    Analytics.logEvent(messageType.rawValue, parameters: [
        "name": messageType.rawValue as NSObject,
        "full_text": messageText as NSObject,
    ])
}
