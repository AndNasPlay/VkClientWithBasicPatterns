//
//  VkTabBarController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit

class VkTabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		UITabBar.appearance().barTintColor = .systemBackground
		tabBar.tintColor = .label
		setupVCs()
	}

	func setupVCs() {
		viewControllers = [
			createNavController(for: FriendsTableViewController(),
								title: "",
								image: UIImage(systemName: "house")!),
			createNavController(for: GroupsTableViewController(),
								title: "Groups Catalog",
								image: UIImage(systemName: "magnifyingglass")!),
			createNavController(for: ProfileTableViewController(),
								title: "Profile",
								image: UIImage(systemName: "house")!)
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
