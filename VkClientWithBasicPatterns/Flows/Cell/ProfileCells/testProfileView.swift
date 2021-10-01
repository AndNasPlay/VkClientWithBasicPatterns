//
//  testProfileView.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 01.10.2021.
//

import UIKit
import Kingfisher

class TestProfileView: UITableViewCell {

	static let identifier = "TestProfileView"

	private let avatarWidthHeight: CGFloat = 80.0

	private let standartIndent: CGFloat = 10.0

	private let buttonHeight: CGFloat = 30.0

	private let textIndent: CGFloat = 20.0

	private let textMultiplier: CGFloat = 0.8

	private(set) lazy var avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = avatarWidthHeight / 2
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	private(set) lazy var profileNameLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileNameFont
		lable.text = "name"
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var profileStatusLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileStatusFont
		lable.text = "Установить статус"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var profileActiveStatusLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileActiveStatusFont
		lable.text = "online"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var editProfileButton: UIButton = {
		let button = UIButton()
		button.setTitle("Редактировать", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	private(set) lazy var iconsAndLablesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private(set) lazy var storyButton1: UIButton = {
		let button = UIButton()
		button.setTitle("История", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		let spacing: CGFloat = 20.0
		button.backgroundColor = .red
		button.imageEdgeInsets = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: spacing)
		button.setBackgroundImage(UIImage(named: "camera"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
		button.setTitleColor(UIColor.vkBlueText, for: .normal)
//		button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -80, right: 0)
		return button
	}()

	private(set) lazy var storyButton2: UIButton = {
		let button = UIButton()
		button.setTitle("История", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.clipsToBounds = false
		button.setBackgroundImage(UIImage(named: "camera"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
		button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		button.setTitleColor(UIColor.vkBlueText, for: .normal)
		button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -80, right: 0)
		return button
	}()

	private(set) lazy var storyButton3: UIButton = {
		let button = UIButton()
		button.setTitle("История", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.clipsToBounds = false
		button.setBackgroundImage(UIImage(named: "camera"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
		button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		button.setTitleColor(UIColor.vkBlueText, for: .normal)
		button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -80, right: 0)
		return button
	}()

	private(set) lazy var storyButton4: UIButton = {
		let button = UIButton()
		button.setTitle("История", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.clipsToBounds = false
		button.setBackgroundImage(UIImage(named: "camera"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
		button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		button.setTitleColor(UIColor.vkBlueText, for: .normal)
		button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -80, right: 0)
		return button
	}()

	private func setupCellCorol() {
		profileActiveStatusLabel.textColor = UIColor.vkGreyText
		editProfileButton.backgroundColor = UIColor.vkButtonGrey
		editProfileButton.setTitleColor(UIColor.vkBlueText, for: .normal)
		profileStatusLabel.textColor = UIColor.vkBlueText
		profileNameLabel.textColor = UIColor.vkBlackText
	}

	private func additionStackView() {
		iconsAndLablesStackView.addArrangedSubview(storyButton1)
		iconsAndLablesStackView.addArrangedSubview(storyButton2)
		iconsAndLablesStackView.addArrangedSubview(storyButton3)
		iconsAndLablesStackView.addArrangedSubview(storyButton4)
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
		contentView.addSubview(iconsAndLablesStackView)
		additionStackView()
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
			avatarImageView.widthAnchor.constraint(equalToConstant: avatarWidthHeight),
			avatarImageView.heightAnchor.constraint(equalToConstant: avatarWidthHeight),
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
			editProfileButton.bottomAnchor.constraint(equalTo: self.iconsAndLablesStackView.topAnchor, constant: -standartIndent),

			iconsAndLablesStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			iconsAndLablesStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -standartIndent),
			iconsAndLablesStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -standartIndent),

			storyButton1.widthAnchor.constraint(equalToConstant: 40.0),
			storyButton2.widthAnchor.constraint(equalToConstant: 40.0),
			storyButton3.widthAnchor.constraint(equalToConstant: 40.0),
			storyButton4.widthAnchor.constraint(equalToConstant: 40.0),
		])
	}
}
