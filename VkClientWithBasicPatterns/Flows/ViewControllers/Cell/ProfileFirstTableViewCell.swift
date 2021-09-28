//
//  ProfileFirstTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit
import Kingfisher

class ProfileFirstTableViewCell: UITableViewCell {

	static let identifier = "ProfileFirstTableViewCell"

	private static let avatarWidthHeight: CGFloat = 80.0

	private let standartIndent: CGFloat = 10.0

	private let buttonHeight: CGFloat = 30.0

	private let textIndent: CGFloat = 20.0

	private let textMultiplier: CGFloat = 0.5

	let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = avatarWidthHeight / 2
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	let profileNameLabel: UILabel = {
		let lable = UILabel()
		lable.font = .systemFont(ofSize: 20, weight: .bold)
		lable.text = "name"
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let profileStatusLabel: UILabel = {
		let lable = UILabel()
		lable.font = .systemFont(ofSize: 15, weight: .regular)
		lable.text = "Установить статус"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let profileActiveStatusLabel: UILabel = {
		let lable = UILabel()
		lable.font = .systemFont(ofSize: 14, weight: .regular)
		lable.text = "online"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let editProfileButton: UIButton = {
		let button = UIButton()
		button.setTitle("Редактировать", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	private func setupCellCorol() {
		profileActiveStatusLabel.textColor = UIColor.vkGreyText
		editProfileButton.backgroundColor = UIColor.vkButtonGrey
		editProfileButton.setTitleColor(UIColor.vkBlueText, for: .normal)
		profileStatusLabel.textColor = UIColor.vkBlueText
		profileNameLabel.textColor = UIColor.vkBlackText
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none
		contentView.addSubview(profileNameLabel)
		contentView.addSubview(avatarImageView)
		contentView.addSubview(profileStatusLabel)
		contentView.addSubview(profileActiveStatusLabel)
		contentView.addSubview(editProfileButton)
		setupCellCorol()
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standartIndent),
			avatarImageView.widthAnchor.constraint(equalToConstant: ProfileFirstTableViewCell.avatarWidthHeight),
			avatarImageView.heightAnchor.constraint(equalToConstant: ProfileFirstTableViewCell.avatarWidthHeight),
			avatarImageView.bottomAnchor.constraint(equalTo: self.editProfileButton.topAnchor, constant: -standartIndent),

			profileNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textIndent),
			profileNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standartIndent),
			profileNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: textMultiplier),

			profileStatusLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textIndent),
			profileStatusLabel.centerYAnchor.constraint(equalTo: self.avatarImageView.centerYAnchor),
			profileStatusLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: textMultiplier),

			profileActiveStatusLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textIndent),
			profileActiveStatusLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: standartIndent),
			profileActiveStatusLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: textMultiplier),

			editProfileButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			editProfileButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -standartIndent),
			editProfileButton.heightAnchor.constraint(equalToConstant: buttonHeight),
			editProfileButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -standartIndent)
		])
	}
}
