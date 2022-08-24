//
//  Endpoint.swift
//  pryanikyTestApp
//
//  Created by admin on 19.07.2022.
//

import Foundation

enum Endpoint {
    case getPryanikySampleJSON
    
    var headers: [String:String] {
        switch self {
        case .getPryanikySampleJSON:
            return ["":""]
        }
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "pryaniky.com"
    }
    
    var path: String {
        switch self {
        case .getPryanikySampleJSON:
//            return "/static/json/sample.json"
            return "/json/data-custom-selected-id.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getPryanikySampleJSON:
            return []
        }
    }
    
    var strURL: String? {
        return makeStringURL()
    }
    
    private func makeStringURL() -> String? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters
        
        return urlComponents.string
    }
    
}
