//
//  FeedViewModel.swift
//  pryanikyTestApp
//
//  Created by admin on 19.07.2022.
//

import Foundation
import UIKit

enum FeedMembers: String {
    case text = "hz"
    case picture = "picture"
    case selector = "selector"
}

protocol FeedableViewModel {
    func startFeed(complition: @escaping ([CellType])->Void)
    func fetchImage(fromURL: String?, complition: @escaping (UIImage)->Void)
}

class FeedViewModel: FeedableViewModel {
    
    private var feedModel: FeedModelProtocol
        
    init(feedModel: FeedModelProtocol) {
        self.feedModel = feedModel
    }
    
    func startFeed(complition: @escaping ([CellType])->Void) {
        feedModel.fetchData(complition: { [weak self] result in
            guard let recivedData = result as? RecivedData else {
                return
            }
            
            guard let cellTypesToView = self?.sortFeedsToView(fromData: recivedData) else {
                return
            }
            
            complition(cellTypesToView)
        })
    }
    
    func fetchImage(fromURL: String?, complition: @escaping (UIImage) -> Void) {
        feedModel.getImage(url: fromURL) { image in
            complition(image)
        }
    }
    
    private func sortFeedsToView(fromData feed: RecivedData) -> [CellType] {
        var feeds = [CellType]()
        
        feed.view.forEach({ name in
            feed.data.forEach({ cell in
                if cell.name == name {
                    feeds.append(cell)
                }
            })
        })
        
        return feeds
    }
    
}
