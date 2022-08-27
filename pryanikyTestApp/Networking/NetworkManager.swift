//
//  NetworkManager.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import Foundation
import UIKit
import Alamofire

protocol NetworkManagerProtocol {
    func fetchData<T: Codable>(endpoint: Endpoint, modelType: T.Type, complition: @escaping (ObtainedResults)->Void)
    func getImage(fromURL: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

enum ObtainedResults {
    case success(result: Codable)
    case failure(error: Error)
}

class NetworkManager: NetworkManagerProtocol {
    func fetchData<T: Codable>(endpoint: Endpoint, modelType: T.Type, complition: @escaping (ObtainedResults)->Void) {
        
        guard let urlString = endpoint.strURL else {
            return
        }
        
        //Создаю request без кэша, чтобы убедиться, что response всегда будет с запроса, а не из кэша. Просто для чистоты теста
        let url = URL(string: urlString)
        
        let req = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 1)
         
        AF.request(req).validate().responseDecodable(of: modelType.self) { result in
            switch result.result {
            case .success(let feed):
                complition(.success(result: feed))
            case .failure(let error):
                complition(.failure(error: error))
            }
        }
    }
    
    func getImage(fromURL: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        
        guard let url = fromURL else {
            return
        }
        
        AF.request(url).validate().responseData { data in
            switch data.result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return
                }
                complition(.success(image))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    
}
