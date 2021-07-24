//
//  RegisterUserResult.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Foundation

struct RegisterUserResult: Codable {
    let result: Int
    let userMessage: String
    let errorMessage: String
}
