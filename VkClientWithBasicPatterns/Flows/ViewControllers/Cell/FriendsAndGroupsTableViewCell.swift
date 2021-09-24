//
//  FriendsAndGroupsTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit

class FriendsAndGroupsTableViewCell: UITableViewCell {

	static let identifier = "FriendsAndGroupsTableViewCell"

	let friendOrGroupNameLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = .systemFont(ofSize: 16, weight: .regular)
		lable.text = "name"
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let friendCityOrGroupDiscrLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .lightGray
		lable.font = .systemFont(ofSize: 13, weight: .regular)
		lable.text = "city"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		return imageView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none
		contentView.addSubview(friendOrGroupNameLabel)
		contentView.addSubview(avatarImageView)
		contentView.addSubview(friendCityOrGroupDiscrLabel)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
			avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
			avatarImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.15),
			avatarImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),

			friendOrGroupNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 10),
			friendOrGroupNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10.0),
			friendOrGroupNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),

			friendCityOrGroupDiscrLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 10),
			friendCityOrGroupDiscrLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 10.0),
			friendCityOrGroupDiscrLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
		])
	}

}
