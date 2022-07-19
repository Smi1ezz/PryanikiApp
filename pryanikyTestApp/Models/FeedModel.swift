//
//  FeedModel.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import Foundation
import UIKit

protocol FeedModelProtocol {
    func fetchData(complition: @escaping (Codable)->Void)
    func getImage(url: String?, complition: @escaping (UIImage)->Void)
}

class FeedModel: FeedModelProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchData(complition: @escaping (Codable) -> Void) {
        let endpoint: Endpoint = .getPryanikySampleJSON
        let modelType = RecivedData.self
        
        networkManager.fetchData(endpoint: endpoint, modelType: modelType, complition: { result in
            
            switch result {
            case .failure(error: let error):
                print("\(error)")
            case .success(result: let feed):
                complition(feed)
            }
            
        })
    }
    
    func getImage(url: String?, complition: @escaping (UIImage) -> Void) {
        networkManager.getImage(fromURL: url) { result in
            switch result {
            case .success(let image):
                complition(image)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
