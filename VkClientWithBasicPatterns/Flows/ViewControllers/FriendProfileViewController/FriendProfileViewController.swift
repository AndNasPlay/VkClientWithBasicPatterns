//
//  FriendProfileViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.09.2021.
//

import UIKit
import Kingfisher

class FriendProfileViewController: UITableViewController, ProfilePhotoTableViewCellDelegate, UICollectionViewDelegate {

	// MARK: - Init model and factory

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

	// MARK: - Variables

	private var tableCellHeight: CGFloat = 210.0
	private var secondTableCellElementHeight: CGFloat = 30.0
	private var secondTableCellFirstElementHeight: CGFloat = 50.0
	private var rowCount: Int = 3
	private var photoCollectionViewHeight: CGFloat = 190.0

	private var photoArray: [Photo] = [Photo]()

	// MARK: - Resources

	private var photoShowViewController = PhotoShowViewController()
	private let imageFinder = ImageForProfileParser()

	// MARK: - view Did Load

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = friendProfile.domain

		self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

		self.tableView.register(FriendProfileFirstTableViewCell.self,
								forCellReuseIdentifier: FriendProfileFirstTableViewCell.identifier)
		self.tableView.register(FriendProfileInfoBlockTableViewCell.self,
								forCellReuseIdentifier: FriendProfileInfoBlockTableViewCell.identifier)
		self.tableView.register(ProfilePhotoTableViewCell.self,
								forCellReuseIdentifier: ProfilePhotoTableViewCell.reuseID)

		loadPhoto()
	}

	// MARK: - Network

	func loadPhoto() {
		self.requestFactory.makeLoadPhotoRequestFactory().loadPhoto(profileId: friendProfile.userId!) { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let photo):
					guard let newPhotoArray: [Photo] = photo.response?.items else { return }
					self.photoArray = newPhotoArray
					self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	func checkElementsCount(friendProfileInfo: FriendsViewModel) -> CGFloat {
		var allElementsHeight: CGFloat = secondTableCellFirstElementHeight
		if (friendProfileInfo.followersCount ?? 0) != 0 {
			allElementsHeight += secondTableCellElementHeight
		}
		if !(friendProfileInfo.cityName ?? "").isEmpty {
			allElementsHeight += secondTableCellElementHeight
		}
		if !(friendProfileInfo.education ?? "").isEmpty {
			allElementsHeight += secondTableCellElementHeight
		}
		return allElementsHeight
	}

	func openPhoto(sender: IndexPath) {
		let newIndexPath = sender

		photoShowViewController.mainImageView.kf.setImage(with: URL(string: imageFinder.getImg(
			from: photoArray[newIndexPath.row]) ?? "https://via.placeholder.com/150x150"))

		photoShowViewController.modalPresentationStyle = .popover
		photoShowViewController.modalTransitionStyle = .crossDissolve
		present(photoShowViewController, animated: true, completion: nil)
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		rowCount
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendProfileFirstTableViewCell.identifier, for: indexPath) as! FriendProfileFirstTableViewCell
			// swiftlint:enable force_cast
			cell.configureCell(friendsViewModel: friendProfile)
			cell.avatarImageView.kf.setImage(with: URL(string: friendProfile.avatarImage ?? "https://via.placeholder.com/50x50"))
			return cell
		} else if indexPath.row == 1 {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendProfileInfoBlockTableViewCell.identifier, for: indexPath) as! FriendProfileInfoBlockTableViewCell
			// swiftlint:enable force_cast
			cell.configureCell(friendsViewModel: friendProfile)
			return cell
		} else {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfilePhotoTableViewCell.reuseID, for: indexPath) as! ProfilePhotoTableViewCell
			// swiftlint:enable force_cast
			cell.configureCell(photo: photoArray)
			cell.photoDelegate = self
			cell.collectionView.delegate = self
			cell.layer.borderWidth = 1.0
			cell.layer.borderColor = UIColor.lightGray.cgColor
			return cell
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return tableCellHeight
		} else if indexPath.row == 1 {
			return checkElementsCount(friendProfileInfo: friendProfile)
		} else {
			return photoCollectionViewHeight
		}
	}
}
