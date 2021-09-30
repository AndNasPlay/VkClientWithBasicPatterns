//
//  FriendProfileViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.09.2021.
//

import UIKit
import Kingfisher

class FriendProfileViewController: UITableViewController {

	let requestFactory: RequestFactory
	let userPhotoUrl: String
	let userName: String
	init(requestFactory: RequestFactory, userPhotoUrl: String, userName: String) {
		self.requestFactory = requestFactory
		self.userName = userName
		self.userPhotoUrl = userPhotoUrl
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	private var tableCellHeight: CGFloat = 140.0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = "Profile"
		self.tableView.separatorColor = UIColor.white

		self.tableView.register(ProfileFirstTableViewCell.self, forCellReuseIdentifier: ProfileFirstTableViewCell.identifier)
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileFirstTableViewCell.identifier, for: indexPath) as! ProfileFirstTableViewCell
		// swiftlint:enable force_cast
		cell.profileNameLabel.text = userName
		cell.avatarImageView.kf.setImage(with: URL(string: userPhotoUrl))

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}
}
