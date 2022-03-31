//
//  NewsTableViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.03.2022.
//

import UIKit
import CoreMIDI

class NewsTableViewController: UITableViewController, NewsTableViewCellDelegate {

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

	private let newsViewModelFactory = NewsViewModelFactory()

	private var newsArray: [NewsViewModel] = [NewsViewModel]()

	private var likeCount: Int = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .white

		self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

		self.tableView.register(NewsTableViewCell.self,
								forCellReuseIdentifier: NewsTableViewCell.identifier)

		loadData()

	}

	func addLike(sender: UIButton) {

		let newIndexPath = IndexPath(row: sender.tag, section: 0)

		guard let cell = tableView.cellForRow(at: newIndexPath) as? NewsTableViewCell else { return }

		if cell.likeButton.tintColor == .gray {
			likeCount = Int(newsArray[newIndexPath.row].likeCount ?? "0") ?? 0

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

//		let newIndexPath = IndexPath(row: sender.tag, section: 0)

//		photoShowViewController.mainImageView.kf.setImage(with: URL(string: wallArray[newIndexPath.row].wallImg ?? "https://via.placeholder.com/150x150"))
//
//		self.navigationController?.pushViewController(photoShowViewController, animated: true)
	}

	private func loadData() {

		self.requestFactory.makeLoadNewsRequestFactory().loadNews { response in
			DispatchQueue.main.async {
				switch response.result {
				case .success(let news):
					guard news.response != nil else { return }
					guard news.response?.items != nil else { return }
					// swiftlint:disable force_unwrapping
					self.newsArray = self.newsViewModelFactory.constructViewModel(from: (news.response?.items)!,
																				  profiles: (news.response?.profiles)!,
																				  groups: (news.response?.groups)!)
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
		newsArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = self.tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell

		cell.configureCell(newsViewModel: newsArray[indexPath.row])
		cell.cellDelegate = self
		cell.likeButton.tag = indexPath.row
		cell.newsImageView.tag = indexPath.row
		cell.layoutIfNeeded()

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		UITableView.automaticDimension
	}
}
