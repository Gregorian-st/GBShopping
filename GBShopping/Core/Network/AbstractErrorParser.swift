//
//  AbstractErrorParser.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
