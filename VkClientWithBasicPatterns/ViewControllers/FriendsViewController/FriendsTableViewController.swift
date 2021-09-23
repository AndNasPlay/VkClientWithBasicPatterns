//
//  FriendsTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

	private var friendsArr = [
		FriendsResult(
			id: 1,
			firstName: "Dima",
			lastName: "Jorin",
			canAccessClosed: true,
			isClosed: false,
			domain: "domain",
			city: City(id: 1, title: "SPB"),
			canInviteToChats: true,
			trackCode: "123"),
		FriendsResult(
			id: 2,
			firstName: "Jora",
			lastName: "Kore",
			canAccessClosed: true,
			isClosed: false,
			domain: "domain",
			city: City(id: 1, title: "Mosccow"),
			canInviteToChats: true,
			trackCode: "123")
	]

	private var tableCellHeight: CGFloat = 70.0

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = "Друзья"
		self.tableView.separatorColor = UIColor.white

		self.tableView.register(FriendsAndGroupsTableViewCell.self, forCellReuseIdentifier: FriendsAndGroupsTableViewCell.identifier)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		friendsArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendsAndGroupsTableViewCell.identifier,
													  for: indexPath) as! FriendsAndGroupsTableViewCell
		// swiftlint:enable force_cast
		cell.friendOrGroupNameLabel.text = "\(friendsArr[indexPath.row].firstName ?? "petrov") \(friendsArr[indexPath.row].lastName ?? "Petro")"
		cell.friendCityOrGroupDiscrLabel.text = friendsArr[indexPath.row].city?.title
		cell.avatarImageView.image = UIImage(named: "testImg")?.roundedImage()

        return cell
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}
}
