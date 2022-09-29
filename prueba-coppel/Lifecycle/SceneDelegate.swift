//
//  SceneDelegate.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 27/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let mainTableView = LoginRouter.createModule()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [mainTableView]
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

