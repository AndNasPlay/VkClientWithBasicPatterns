//
//  FriendsTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import UIKit
import Kingfisher

class FriendsTableViewController: UITableViewController {

	let requestFactory: RequestFactory
	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	private func loadData() {
		self.requestFactory.makeLoadFriendsRequestFactory().loadFriends(count: 50) { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let catalog):
					guard catalog.response?.items?.count ?? 0 > 0 else { return }
					// swiftlint:disable force_unwrapping
						self.friendsArr.append(contentsOf: (catalog.response?.items)!)
					// swiftlint:enable force_unwrapping
						self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	private var friendsArr = [FriendsResult]()
	private var tableCellHeight: CGFloat = 70.0

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = "Друзья"
		self.tableView.separatorColor = UIColor.white
		loadData()

		self.tableView.register(FriendsAndGroupsTableViewCell.self, forCellReuseIdentifier: FriendsAndGroupsTableViewCell.identifier)
    }

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
		if friendsArr[indexPath.row].photo50 != nil {
			cell.avatarImageView.kf.setImage(with: URL(string: friendsArr[indexPath.row].photo50 ?? "http://placehold.it/50x50"))
		} else {
			cell.avatarImageView.image = UIImage(named: "testImg")
		}
        return cell
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}
}
