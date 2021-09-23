//
//  ProfileFirstTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit

class ProfileFirstTableViewCell: UITableViewCell {

	static let identifier = "ProfileFirstTableViewCell"

	let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		return imageView
	}()

	let profileNameLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = .systemFont(ofSize: 22, weight: .bold)
		lable.text = "name"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let profileStatusLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .systemBlue
		lable.font = .systemFont(ofSize: 16, weight: .regular)
		lable.text = "Установить статус"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let profileActiveStatusLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .lightGray
		lable.font = .systemFont(ofSize: 14, weight: .regular)
		lable.text = "online"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	let editProfileButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .lightGray
		button.setTitle("Редактировать", for: .normal)
		button.tintColor = UIColor.systemBlue
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none
		contentView.addSubview(profileNameLabel)
		contentView.addSubview(avatarImageView)
		contentView.addSubview(profileStatusLabel)
		contentView.addSubview(profileActiveStatusLabel)
		contentView.addSubview(editProfileButton)
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
			avatarImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2),
			editProfileButton.bottomAnchor.constraint(equalTo: self.editProfileButton.topAnchor, constant: 10),

			profileNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 20),
			profileNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0),
			profileNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),

			profileStatusLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 20),
			profileStatusLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10),
			profileStatusLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),

			profileActiveStatusLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 20),
			profileActiveStatusLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 10.0),
			profileActiveStatusLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),

			editProfileButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 10.0),
			editProfileButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10.0),
			editProfileButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10.0),
			editProfileButton.heightAnchor.constraint(equalToConstant: 30),
			editProfileButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
		])
	}

}
