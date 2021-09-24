//
//  SceneDelegate.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(frame: UIScreen.main.bounds)
		let newController = LoginViewController()
		window?.rootViewController = newController
		window?.makeKeyAndVisible()
		window?.windowScene = windowScene
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
