//
//  WallTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.03.2022.
//

import UIKit
import Kingfisher

class WallTableViewController: UITableViewController {

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

	private let wallViewModelFactory = WallViewModelFactory()

	private var wallArray: [WallViewModel] = [WallViewModel]()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white

		self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

		self.tableView.register(WallTableViewCell.self,
								forCellReuseIdentifier: WallTableViewCell.identifier)

		loadData()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.tableView.reloadData()
	}

	private func loadData() {

		guard friendProfile.userId != nil else { return }

		self.requestFactory.makeLoadWallRequestFactory().loadWall(profileId: friendProfile.userId!) { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let wall):
					guard wall.response != nil else { return }
					guard wall.response?.items != nil else { return }
					// swiftlint:disable force_unwrapping
					self.wallArray = self.wallViewModelFactory.constructViewModel(from: (wall.response?.items)!)
					// swiftlint:enable force_unwrapping
					self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		wallArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = self.tableView.dequeueReusableCell(withIdentifier: WallTableViewCell.identifier, for: indexPath) as! WallTableViewCell

		cell.configureCell(wallViewModel: wallArray[indexPath.row])

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		UITableView.automaticDimension
	}
}
