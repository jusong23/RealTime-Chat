//
//  SceneDelegate.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)

        let rootViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

}

