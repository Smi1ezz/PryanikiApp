//
//  Endpoint.swift
//  pryanikyTestApp
//
//  Created by admin on 19.07.2022.
//

import Foundation

enum MyUrlError: Error {
    case wrongUrlError
    
    var descr: String {
        return "Wrong url. Correct endpoint"
    }
}

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
            return "/static/json/sample.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getPryanikySampleJSON:
            return []
        }
    }
    
    var url: URL? {
        do {
            let url = try makeURL()
            return url
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
    }
    
    var request: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    private func makeURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters
        guard let url = urlComponents.url else {
            throw MyUrlError.wrongUrlError
        }
        return url
    }
    
}
