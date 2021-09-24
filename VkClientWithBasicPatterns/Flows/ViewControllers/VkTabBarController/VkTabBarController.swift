//
//  VkTabBarController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit

class VkTabBarController: UITabBarController {

	let factory = RequestFactory(baseUrl: UserSettings.baseUrl)

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		UITabBar.appearance().barTintColor = .systemBackground
		tabBar.tintColor = .label
		setupVCs()
	}

	func setupVCs() {
		viewControllers = [
			createNavController(
				for: FriendsTableViewController(requestFactory: factory),
				// swiftlint:disable force_unwrapping
				image: UIImage(systemName: "house")!),
			createNavController(
				for: GroupsTableViewController(requestFactory: factory),
				image: UIImage(systemName: "magnifyingglass")!),
			createNavController(
				for: ProfileTableViewController(requestFactory: factory),
				image: UIImage(systemName: "house")!)
			// swiftlint:enable force_unwrapping
		]
	}

	fileprivate func createNavController(
		for rootViewController: UIViewController,
		image: UIImage
	) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.image = image
		navController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title
		return navController
	}
}