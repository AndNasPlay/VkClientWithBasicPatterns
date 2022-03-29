//
//  WallTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.03.2022.
//

import UIKit
import Kingfisher

class WallTableViewController: UITableViewController, WallTableViewCellDelegate {

	let requestFactory: RequestFactory

	let friendProfile: FriendsViewModel

	private var photoShowViewController = PhotoShowViewController()

	private var likeCount: Int = 0

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

	func showPhoto(sender: UIImageView) {

		let newIndexPath = IndexPath(row: sender.tag, section: 0)

		photoShowViewController.mainImageView.kf.setImage(with: URL(string: wallArray[newIndexPath.row].wallImg ?? "https://via.placeholder.com/150x150"))

		self.navigationController?.pushViewController(photoShowViewController, animated: true)
	}

	private func loadData() {

		guard let friendId = friendProfile.userId else { return }

		self.requestFactory.makeLoadWallRequestFactory().loadWall(profileId: friendId) { response in
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
		cell.cellDelegate = self
		cell.likeButton.tag = indexPath.row
		cell.wallImageView.tag = indexPath.row

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		UITableView.automaticDimension
	}

}
