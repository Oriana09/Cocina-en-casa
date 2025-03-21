//
//  SceneDelegate.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/11/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.setNavigationBarAppearance()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let viewModel =  RecipeListViewModel()
        let navigationController = UINavigationController(
            rootViewController: RecipeListViewController(
                viewModel: viewModel
            )
        )
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setNavigationBarAppearance() {
        if #available(iOS 15, *) {
            let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.shadowColor = .clear
            UINavigationBar.appearance().tintColor = .systemGreen
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        } else {
            UINavigationBar.appearance().tintColor = .systemGreen
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    func sceneWillResignActive(_ scene: UIScene) {
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}



