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
	let friendProfile: FriendsViewModel
	init(requestFactory: RequestFactory, friendProfile: FriendsViewModel) {
		self.requestFactory = requestFactory
		self.friendProfile = friendProfile
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	private var tableCellHeight: CGFloat = 210.0
	private var secondTableCellHeight: CGFloat = 140.0
	private var secondTableCellElementHeight: CGFloat = 80.0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.navigationController?.navigationItem.title = friendProfile.nameLable

		self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
		self.tableView.register(FriendProfileFirstTableViewCell.self, forCellReuseIdentifier: FriendProfileFirstTableViewCell.identifier)
		self.tableView.register(FriendProfileInfoBlockTableViewCell.self, forCellReuseIdentifier: FriendProfileInfoBlockTableViewCell.identifier)
	}

	func checkElementsCount(friendProfileInfo: FriendsViewModel) -> CGFloat {
		var allElementsHeight: CGFloat = secondTableCellElementHeight
		if (friendProfileInfo.followersCount ?? 0) != 0 {
			allElementsHeight += 20
		}
		if !(friendProfileInfo.cityName ?? "").isEmpty {
			allElementsHeight += 20
		}
		if !(friendProfileInfo.education ?? "").isEmpty {
			allElementsHeight += 20
		}
		return allElementsHeight
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		2
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendProfileFirstTableViewCell.identifier, for: indexPath) as! FriendProfileFirstTableViewCell
			// swiftlint:enable force_cast
			cell.configureCell(friendsViewModel: friendProfile)
			cell.avatarImageView.kf.setImage(with: URL(string: friendProfile.avatarImage ?? "http://placehold.it/50x50"))
			return cell
		} else {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendProfileInfoBlockTableViewCell.identifier, for: indexPath) as! FriendProfileInfoBlockTableViewCell
			// swiftlint:enable force_cast
			cell.configureCell(friendsViewModel: friendProfile)
			return cell
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return tableCellHeight
		} else {
			return checkElementsCount(friendProfileInfo: friendProfile)
		}
	}
}
