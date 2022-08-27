//
//  Endpoint.swift
//  pryanikyTestApp
//
//  Created by admin on 19.07.2022.
//

import Foundation

enum Endpoint {
    case getPryanikySampleJSON, getPryanikiChatMoreItemsInData, getPryanikiChatCustomData
    
    var headers: [String:String] {
        switch self {
        case .getPryanikySampleJSON:
            return ["":""]
        case .getPryanikiChatMoreItemsInData:
            return ["":""]
        case .getPryanikiChatCustomData:
            return ["":""]
        }
        
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        switch self {
        case .getPryanikySampleJSON:
            return "pryaniky.com"
        case .getPryanikiChatMoreItemsInData:
            return "chat.pryaniky.com"
        case .getPryanikiChatCustomData:
            return "chat.pryaniky.com"
        }
    }
    
    var path: String {
        switch self {
        case .getPryanikySampleJSON:
            return "/static/json/sample.json"
        case .getPryanikiChatMoreItemsInData:
            return "/json/data-custom-order-much-more-items-in-data.json"
        case .getPryanikiChatCustomData:
            return "/json/data-default-order-custom-data-in-view.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getPryanikySampleJSON:
            return []
        case .getPryanikiChatMoreItemsInData:
            return []
        case .getPryanikiChatCustomData:
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
