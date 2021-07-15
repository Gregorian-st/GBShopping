//
//  UserData.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 14.07.2021.
//

import Foundation

class UserData {
    static let instance = UserData()
    private init() {}
    
    var user = User(
        id: 0,
        login: "",
        name: "",
        surname: "",
        email: "",
        gender: "",
        creditCard: "",
        bio: ""
    )
}
