//
//  FriendsTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController, CAAnimationDelegate {

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

	private let friendsViewModelFactory = FriendsViewModelFactory()
	private var friendsViewModels: [FriendsViewModel] = []
	private var tableCellHeight: CGFloat = 70.0

	private func loadData() {
		self.requestFactory.makeLoadFriendsWithPeoxyRequestFactory().loadFriends { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let catalog):
					guard catalog.response?.items?.count ?? 0 > 0 else { return }
					// swiftlint:disable force_unwrapping
					self.friendsViewModels = self.friendsViewModelFactory.constructViewModel(from: (catalog.response?.items)!)
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
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white
		self.title = "Друзья"
		self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
		loadData()

		self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		friendsViewModels.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = self.tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier,
													  for: indexPath) as! FriendsTableViewCell
		// swiftlint:enable force_cast

		cell.configureCell(friendsViewModel: friendsViewModels[indexPath.row])
		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		tableCellHeight
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		guard let cell = tableView.cellForRow(at: indexPath) as? FriendsTableViewCell else { return }

		cell.avatarImageView.transform = CGAffineTransform(translationX: 0, y: -8)

		UIView.animate(withDuration: 1.0,
					   delay: 0.0,
					   usingSpringWithDamping: 0.5,
					   initialSpringVelocity: 0.8,
					   options: [.curveLinear]
		) {
			cell.avatarImageView.transform = .identity

		} completion: { _ in
			let profileController = ParentFriendProfileViewController(
				requestFactory: self.requestFactory,
				friendProfile: self.friendsViewModels[indexPath.row])
			self.navigationController?.pushViewController(profileController, animated: true)
		}
	}
}
