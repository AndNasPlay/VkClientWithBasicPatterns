//
//  ProfileTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit

class ProfileTableViewController: UITableViewController, WallTableViewCellDelegate, ProfilePhotoTableViewCellDelegate, UICollectionViewDelegate {

	let requestFactory: RequestFactory

	private var tableCellHeight: CGFloat = 210.0
	private var secondTableCellHeight: CGFloat = 140.0
	private var sectionCount = 3
	private var rowCount = 1
	private var likeCount: Int = 0

	private let profileViewModelFactory = ProfileViewModelFactory()

	private let wallViewModelFactory = WallViewModelFactory()
	private var profileViewModel = ProfileViewModel(name: "", homeTown: "")
	private var wallArray: [WallViewModel] = [WallViewModel]()
	private var photoShowViewController = PhotoShowViewController()
	private var photoArray: [Photo] = [Photo]()

	private let imageFinder = ImageForProfileParser()

	private var userPhotoUrl: String?
	private let profileImageSize: String = "p"

	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self

		self.tableView.backgroundColor = .white
		self.tableView.separatorColor = UIColor.white

		self.tableView.register(ProfileFirstTableViewCell.self, forCellReuseIdentifier: ProfileFirstTableViewCell.identifier)
		self.tableView.register(ProfileInfoBlockViewCell.self, forCellReuseIdentifier: ProfileInfoBlockViewCell.identifier)
		self.tableView.register(ProfilePhotoTableViewCell.self, forCellReuseIdentifier: ProfilePhotoTableViewCell.reuseID)
		self.tableView.register(WallTableViewCell.self, forCellReuseIdentifier: WallTableViewCell.identifier)
		loadData()
		loadPhoto()
		loadWall()
		loadNews()
	}

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
	}

	private func loadNews() {
		self.requestFactory.makeLoadNewsRequestFactory().loadNews { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let news):
					guard news.response != nil else { return }
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	func loadPhoto() {
		self.requestFactory.makeLoadPhotoRequestFactory().loadPhoto(profileId: UserSettings.shared.userId) { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let photo):
					guard let new: PhotoUrl = (photo.response?.items?.first?.sizes?.first(where: { $0.type == self.profileImageSize })) else { return }
					guard let newPhotoArray: [Photo] = photo.response?.items else { return }
					self.photoArray = newPhotoArray
					self.userPhotoUrl = new.url
					self.tableView.reloadData()
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}

	func loadWall() {
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

	func addLike(sender: UIButton) {

		let newIndexPath = IndexPath(row: sender.tag, section: 0)

		guard let cell = tableView.cellForRow(at: newIndexPath) as? WallTableViewCell else { return }

		if cell.likeButton.tintColor == .gray {
			likeCount = Int(wallArray[newIndexPath.row].likeCount ?? "0") ?? 0

			likeCount += 1

			cell.likeCountLable.text = "\(likeCount)"

			cell.likeButton.tintColor = .red
			cell.likeButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

			UIView.animate(withDuration: 1.0) {
				cell.likeButton.transform = .identity
			}
		} else {

			likeCount -= 1

			cell.likeCountLable.text = "\(likeCount)"

			cell.likeButton.tintColor = .gray
			cell.likeButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

			UIView.animate(withDuration: 1.0) {
				cell.likeButton.transform = .identity
			}
		}
	}

	func openPhoto(sender: IndexPath) {
		let newIndexPath = sender

		photoShowViewController.mainImageView.kf.setImage(with: URL(string: imageFinder.getImg(
			from: photoArray[newIndexPath.row]) ?? "https://via.placeholder.com/150x150"))

		self.navigationController?.pushViewController(photoShowViewController, animated: true)
	}

	func showPhoto(sender: UIImageView) {

		let newIndexPath = IndexPath(row: sender.tag, section: 0)

		photoShowViewController.mainImageView.kf.setImage(with: URL(string: wallArray[newIndexPath.row].wallImg ?? "https://via.placeholder.com/150x150"))

		self.navigationController?.pushViewController(photoShowViewController, animated: true)
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		3 + wallArray.count
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
		} else if indexPath.row == 2 {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfilePhotoTableViewCell.reuseID, for: indexPath) as! ProfilePhotoTableViewCell
			// swiftlint:enable force_cast
			cell.configureCell(photo: photoArray)
			cell.photoDelegate = self
			cell.collectionView.delegate = self
			cell.layer.borderWidth = 1.0
			cell.layer.borderColor = UIColor.lightGray.cgColor
			return cell
		} else {
			// swiftlint:disable force_cast
			let cell = self.tableView.dequeueReusableCell(withIdentifier: WallTableViewCell.identifier, for: indexPath) as! WallTableViewCell
			// swiftlint:enable force_cast
			let newIndexPath = indexPath.row - 3
			cell.configureCell(wallViewModel: wallArray[newIndexPath])
			cell.cellDelegate = self
			cell.likeButton.tag = indexPath.row
			return cell
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return tableCellHeight
		} else if indexPath.row == 1 {
			return secondTableCellHeight
		} else if indexPath.row == 2 {
			return 190.0
		} else {
			return UITableView.automaticDimension
		}
	}
}
