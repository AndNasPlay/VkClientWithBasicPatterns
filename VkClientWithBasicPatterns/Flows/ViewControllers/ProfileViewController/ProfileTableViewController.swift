//
//  ProfileTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit

class ProfileTableViewController: UITableViewController {

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

	private var tableCellHeight: CGFloat = 130.0

	private var profileUser: Profile?

	private func loadData() {
		self.requestFactory.makeLoadProfileRequestFactory().loadProfile { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let profile):
					self.profileUser = profile.response
					self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = "Profile"
		self.tableView.separatorColor = UIColor.white
		loadData()

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
		let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileFirstTableViewCell.identifier,
													  for: indexPath) as! ProfileFirstTableViewCell
		// swiftlint:enable force_cast
		cell.avatarImageView.image = UIImage(named: "testImg")?.roundedImage()
		cell.profileNameLabel.text = "\(profileUser?.firstName ?? "name") \(profileUser?.lastName ?? "")"

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}
}
