//
//  ProfileTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit
import Kingfisher

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

	private var tableCellHeight: CGFloat = 140.0

	private var profileUser: Profile?

	private var userPhotoUrl: String?

	private let profileImageSize: String = "p"

	private func loadData() {
		self.requestFactory.makeLoadProfileRequestFactory().loadProfile { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let profile):
					self.profileUser = profile.response
					self.title = profile.response?.screenName
					self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}

		self.requestFactory.makeLoadPhotoRequestFactory().loadPhoto { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let photo):
					guard let new: PhotoUrl = (photo.response?.items?.first?.sizes?.first(where: { $0.type == self.profileImageSize })) else { return }
					self.userPhotoUrl = new.url
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
		let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileFirstTableViewCell.identifier, for: indexPath) as! ProfileFirstTableViewCell
		// swiftlint:enable force_cast
		cell.profileNameLabel.text = "\(profileUser?.firstName ?? "name") \(profileUser?.lastName ?? "")"
		if userPhotoUrl != nil {
			cell.avatarImageView.kf.setImage(with: URL(string: userPhotoUrl ?? "http://placehold.it/50x50"))
		} else {
			cell.avatarImageView.image = UIImage(named: "testImg")
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}
}
