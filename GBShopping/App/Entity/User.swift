//
//  User.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let name: String
    let surname: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case surname = "user_lastname"
        case email = "email"
        case gender = "gender"
        case creditCard = "credit_card"
        case bio = "bio"
    }
}
