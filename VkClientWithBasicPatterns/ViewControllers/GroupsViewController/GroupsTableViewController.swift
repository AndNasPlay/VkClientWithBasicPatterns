//
//  GroupsTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {

	private var groupsArr = [
		GroupResult(
			id: 1,
			name: "Pikabu",
			screenName: "Pikabu",
			isClosed: 1,
			type: "231",
			isAdmin: 0,
			isMember: 1,
			isAdvertiser: 0,
			photo50: "ad",
			photo100: "asd",
			photo200: "ad",
			description: "norm gruppa")
	]

	private var tableCellHeight: CGFloat = 70.0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = "Все сообщества"
		self.tableView.separatorColor = UIColor.white

		self.tableView.register(FriendsAndGroupsTableViewCell.self, forCellReuseIdentifier: FriendsAndGroupsTableViewCell.identifier)

	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		groupsArr.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendsAndGroupsTableViewCell.identifier,
													  for: indexPath) as! FriendsAndGroupsTableViewCell
		// swiftlint:enable force_cast
		cell.friendOrGroupNameLabel.text = "\(groupsArr[indexPath.row].name ?? "petrov")"
		cell.friendCityOrGroupDiscrLabel.text = groupsArr[indexPath.row].description
		cell.avatarImageView.image = UIImage(named: "testImg")?.roundedImage()

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}
}
