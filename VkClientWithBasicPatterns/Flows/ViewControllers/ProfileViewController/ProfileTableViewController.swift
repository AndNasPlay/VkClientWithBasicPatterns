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

	private var tableCellHeight: CGFloat = 210.0

	private let profileViewModelFactory = ProfileViewModelFactory()
	private var profileViewModel: ProfileViewModel?
	private var userPhotoUrl: String?
	private let profileImageSize: String = "p"

	private func loadData() {
		self.requestFactory.makeLoadProfileRequestFactory().loadProfile { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let profile):
					guard profile.response != nil else { return }
					// swiftlint:disable force_unwrapping
					self.profileViewModel = self.profileViewModelFactory.constructViewModel(from: profile.response!)
					// swiftlint:enable force_unwrapping
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
		cell.profileNameLabel.text = profileViewModel?.name
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
