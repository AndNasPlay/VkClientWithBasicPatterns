//
//  GroupsTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 29.09.2021.
//

import UIKit
import Kingfisher

class GroupsTableViewCell: UITableViewCell {

	static let identifier = "GroupsTableViewCell"

	private static let avatarWidthHeight: CGFloat = 50.0

	private let standartIndent: CGFloat = 10.0

	private let activityMultiplier: CGFloat = 0.5

	private let nameMultiplier: CGFloat = 0.7

	let groupNameLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let groupActivityLabel: UILabel = {
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
		contentView.addSubview(groupNameLabel)
		contentView.addSubview(avatarImageView)
		contentView.addSubview(groupActivityLabel)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	func configureCell(groupsViewModel: GroupsViewModel) {
		groupNameLabel.text = groupsViewModel.nameLable
		groupActivityLabel.text = groupsViewModel.description
		if groupsViewModel.avatarImage != nil {
			avatarImageView.kf.setImage(with: URL(string: groupsViewModel.avatarImage ?? "https://via.placeholder.com/50x50"))
		} else {
			avatarImageView.image = UIImage(named: "testImg")
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standartIndent),
			avatarImageView.widthAnchor.constraint(equalToConstant: GroupsTableViewCell.avatarWidthHeight),
			avatarImageView.heightAnchor.constraint(equalToConstant: GroupsTableViewCell.avatarWidthHeight),
			avatarImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -standartIndent),

			groupNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: standartIndent),
			groupNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -standartIndent),
			groupNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: nameMultiplier),

			groupActivityLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: standartIndent),
			groupActivityLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: standartIndent),
			groupActivityLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: activityMultiplier)
		])
	}

}
