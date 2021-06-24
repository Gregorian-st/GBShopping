//
//  ErrorParser.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    
    func parse(_ result: Error) -> Error {
        return result
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
    
}
