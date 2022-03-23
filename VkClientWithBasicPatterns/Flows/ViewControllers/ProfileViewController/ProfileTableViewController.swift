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
	private var secondTableCellHeight: CGFloat = 140.0
	private var sectionCount = 3
	private var rowCount = 1

	private let profileViewModelFactory = ProfileViewModelFactory()
	private let wallViewModelFactory = WallViewModelFactory()
	private var profileViewModel = ProfileViewModel(name: "", homeTown: "")
	private var wallArray: [WallViewModel] = [WallViewModel]()
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

		self.requestFactory.makeLoadWallRequestFactory().loadWall(profileId: UserSettings.shared.userId) { response in
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

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Profile"
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.tableView.separatorColor = UIColor.white
		self.tableView.register(ProfileFirstTableViewCell.self, forCellReuseIdentifier: ProfileFirstTableViewCell.identifier)
		self.tableView.register(ProfileInfoBlockViewCell.self, forCellReuseIdentifier: ProfileInfoBlockViewCell.identifier)
		self.tableView.register(WallTableViewCell.self, forCellReuseIdentifier: WallTableViewCell.identifier)
		loadData()
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		2 + wallArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileFirstTableViewCell.identifier, for: indexPath) as! ProfileFirstTableViewCell
			// swiftlint:enable force_cast
			cell.configureCell(profileViewModel: profileViewModel)
			if userPhotoUrl != nil {
				cell.avatarImageView.kf.setImage(with: URL(string: userPhotoUrl ?? "https://via.placeholder.com/150x150"))
			} else {
				cell.avatarImageView.image = UIImage(named: "testImg")
			}
			return cell
		} else if indexPath.row == 1 {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileInfoBlockViewCell.identifier, for: indexPath) as! ProfileInfoBlockViewCell
			// swiftlint:enable force_cast
			cell.configureCell(profileViewModel: profileViewModel)
			return cell
		} else {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: WallTableViewCell.identifier, for: indexPath) as! WallTableViewCell
			// swiftlint:enable force_cast
			let newIndexPath = indexPath.row - 2
			cell.configureCell(wallViewModel: wallArray[newIndexPath])
			return cell
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return tableCellHeight
		} else if indexPath.row == 1 {
			return secondTableCellHeight
		} else {
			return UITableView.automaticDimension
		}
	}
}
