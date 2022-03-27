//
//  ProfilePhotoTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit
import Kingfisher

protocol ProfilePhotoTableViewCellDelegate: AnyObject {
	func openPhoto(sender: IndexPath)
}

class ProfilePhotoTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, PhotoCollectionViewCellDelegate {

	static let reuseID = "profilePhotoTableViewCell"

	var photoArr: [Photo] = [Photo]()

	private let imageFinder = ImageForProfileParser()

	weak var photoDelegate: ProfilePhotoTableViewCellDelegate?

	private(set) lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layout.minimumInteritemSpacing = 10
		layout.minimumLineSpacing = 10
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero,
											  collectionViewLayout: layout)

		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.contentView.addSubview(collectionView)

		self.collectionView.backgroundColor = .white

		self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseID)

		self.collectionView.dataSource = self
		self.collectionView.delegate = self

		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func showPhoto(sender: UIImageView) {
		let newIndexPath = IndexPath(row: sender.tag, section: 0)
		photoDelegate?.openPhoto(sender: newIndexPath)
	}

	func configureCell(photo: [Photo]) {
		self.photoArr = photo
		self.collectionView.reloadData()
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.photoArr.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// swiftlint:disable force_cast
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseID, for: indexPath) as! PhotoCollectionViewCell
		// swiftlint:enable force_cast
		cell.profileImageView.kf.setImage(with: URL(string: imageFinder.getImg(from: photoArr[indexPath.item]) ?? "https://via.placeholder.com/150x150"))
		cell.profileImageView.tag = indexPath.row
		cell.delegate = self

		return cell
	}

	 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	 }

	func setup() {

		NSLayoutConstraint.activate([

			collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5.0),
			collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5.0),
			collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)

		])
	}

}
