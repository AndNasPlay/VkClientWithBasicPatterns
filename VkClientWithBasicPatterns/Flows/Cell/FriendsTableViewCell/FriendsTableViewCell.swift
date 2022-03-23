//
//  FriendsTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit
import Kingfisher

class FriendsTableViewCell: UITableViewCell {

	static let identifier = "FriendsTableViewCell"

	private static let avatarWidthHeight: CGFloat = 50.0

	private let standartIndent: CGFloat = 10.0

	private let cityMultiplier: CGFloat = 0.5

	private let nameMultiplier: CGFloat = 0.7

	let friendNameLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let friendCityLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .lightGray
		lable.font = UIFont.subTitleCellFont
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = avatarWidthHeight / 2
		return imageView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none
		contentView.addSubview(friendNameLabel)
		contentView.addSubview(avatarImageView)
		contentView.addSubview(friendCityLabel)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	func configureCell(friendsViewModel: FriendsViewModel) {
		friendNameLabel.text = friendsViewModel.nameLable
		friendCityLabel.text = friendsViewModel.cityName
		if friendsViewModel.avatarImage != nil {
			avatarImageView.kf.setImage(with: URL(string: friendsViewModel.avatarImage ?? "https://via.placeholder.com/50x50"))
		} else {
			avatarImageView.image = UIImage(named: "testImg")
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standartIndent),
			avatarImageView.widthAnchor.constraint(equalToConstant: FriendsTableViewCell.avatarWidthHeight),
			avatarImageView.heightAnchor.constraint(equalToConstant: FriendsTableViewCell.avatarWidthHeight),
			avatarImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -standartIndent),

			friendNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: standartIndent),
			friendNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -standartIndent),
			friendNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: nameMultiplier),

			friendCityLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: standartIndent),
			friendCityLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: standartIndent),
			friendCityLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cityMultiplier)
		])
	}

}
