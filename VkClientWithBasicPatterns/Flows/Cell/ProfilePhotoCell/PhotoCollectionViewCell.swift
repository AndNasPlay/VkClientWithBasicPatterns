//
//  PhotoCollectionViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

	static let reuseID = "photoCollectionViewCell"

	private(set) lazy var profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10.0
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func setupUI() {

		self.contentView.addSubview(profileImageView)
		self.contentView.backgroundColor = .white

		NSLayoutConstraint.activate([

			profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			profileImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			profileImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			profileImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
		])
	}

}
