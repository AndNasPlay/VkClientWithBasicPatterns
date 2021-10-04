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
				title: "Друзья",
				image: UIImage(named: "friends")!),
			createNavController(
				for: GroupsTableViewController(requestFactory: factory),
				title: "Все сообщества",
				image: UIImage(named: "group")!),
			createNavController(
				for: ProfileTableViewController(requestFactory: factory),
				title: "Profile",
				image: UIImage(named: "profile")!)
			// swiftlint:enable force_unwrapping
		]
	}

	fileprivate func createNavController(
		for rootViewController: UIViewController,
		title: String,
		image: UIImage
	) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		navController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title
		return navController
	}
}
