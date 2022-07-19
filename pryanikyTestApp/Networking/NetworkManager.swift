//
//  NetworkManager.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import Foundation
import UIKit

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
        
        let session = URLSession.shared
        
        guard let url = endpoint.url else { return }
        
        session.dataTask(with: url) { data, resp, error in
            var result: ObtainedResults
            let decoder = JSONDecoder()
            
            defer {
                DispatchQueue.main.async {
                    complition(result)
                }
            }
            
            guard error == nil, let data = data else {
                result = .failure(error: error!)
                return
            }
            
            do {
                let resultOfRequest = try decoder.decode(modelType.self, from: data)
                print("Получена модель \(modelType)")
                result = .success(result: resultOfRequest)
            } catch {
                result = .failure(error: error)
            }
        }
        .resume()
    }
    
    func getImage(fromURL: String?, complition: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = fromURL else {
            return
        }

        guard let url = URL(string: url) else {
            return
        }
        
        session.dataTask(with: url) { data, _, error in
            if error == nil, let parsData = data {
                guard let image = UIImage(data: parsData) else {
                    return
                }
                complition(.success(image))
            } else {
                complition(.failure(error!))
            }
        }
        .resume()
    }
    
}
