//
//  SceneDelegate.swift
//  YoungTalent
//
//  Created by admin on 7.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        guard let isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else{ return }
        
        let window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeVC")
        let rootViewController = UINavigationController(rootViewController: welcomeViewController)
        rootViewController.isNavigationBarHidden = true
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = isDarkMode ? .dark: .light
    }

}

