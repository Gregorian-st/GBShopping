//
//  GetBasketResult.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 06.07.2021.
//

import Foundation

struct GetBasketResult: Codable {
    let amount: Float
    let countGoods: Int
    let contents: [ProductBasket]
    
    init() {
        amount = 0
        countGoods = 0
        contents = []
    }
}
