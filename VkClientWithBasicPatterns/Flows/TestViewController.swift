//
//  TestViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 01.10.2021.
//

import UIKit

class TestViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		self.view.addSubview(storyButton1)
		updateC()
	}

		private(set) lazy var storyButton1: IconsUIButton = {
			let button = IconsUIButton(with: IconsButtonViewModel(iconTitleLable: "Проверка", iconeImageView: "photo"))
			button.translatesAutoresizingMaskIntoConstraints = false
			button.backgroundColor = .red
			return button
		}()

//	private(set) lazy var storyButton1: UIButton = {
//		let button = UIButton()
//		button.translatesAutoresizingMaskIntoConstraints = false
//		button.backgroundColor = .red
//		return button
//	}()

	func updateC() {
		NSLayoutConstraint.activate([
			storyButton1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			storyButton1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			storyButton1.widthAnchor.constraint(equalToConstant: 100.0),
			storyButton1.heightAnchor.constraint(equalToConstant: 100.0)
		])
	}
}
