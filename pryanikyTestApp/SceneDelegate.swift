//
//  SceneDelegate.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let mainScene = (scene as? UIWindowScene) else { return }
        
        let mainWindow = UIWindow(windowScene: mainScene)
        
        let networker = NetworkManager()
        
        let model = FeedModel(networkManager: networker)
        
        let viewModel = FeedViewModel(feedModel: model)
                
        mainWindow.rootViewController = MainViewController(feedableViewModel: viewModel)
        mainWindow.makeKeyAndVisible()
        window = mainWindow
    }

}

