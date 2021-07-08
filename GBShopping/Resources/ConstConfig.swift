//
//  ConstConfig.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 29.06.2021.
//

import Foundation

struct ConstConfig {
    #if DEBUG
        static let baseURLString = "http://127.0.0.1:8080/"
    #else
        static let baseURLString = "https://remembrance-zed-73259.herokuapp.com/"
    #endif
}
