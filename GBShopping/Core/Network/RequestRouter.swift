//
//  RequestRouter.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Alamofire
import Firebase

enum RequestRouterEncoding {
    case url, json
}

protocol RequestRouter: URLRequestConvertible {

    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var fullUrl: URL { get }
    var encoding: RequestRouterEncoding { get }

}

extension RequestRouter {

    var fullUrl: URL {
        guard let url = URL(string: baseUrl)
        else {
            Crashlytics.crashlytics().log("baseURL Error!")
            fatalError("baseURL Error!")
        }

        return url.appendingPathComponent(path)
    }

    var encoding: RequestRouterEncoding {
        return .url
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        
        urlRequest.httpMethod = method.rawValue
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
