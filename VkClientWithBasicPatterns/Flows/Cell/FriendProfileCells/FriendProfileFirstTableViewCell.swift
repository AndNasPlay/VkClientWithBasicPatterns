//
//  FriendProfileFirstTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 05.10.2021.
//

import UIKit

class FriendProfileFirstTableViewCell: UITableViewCell {

	static let identifier = "FriendProfileFirstTableViewCell"

	private let avatarWidthHeight: CGFloat = 80.0

	private let standartIndent: CGFloat = 10.0

	private let bottomIndent: CGFloat = 20.0

	private let onlineIndent: CGFloat = 15.0

	private let buttonHeight: CGFloat = 35.0

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

	private(set) lazy var profileActiveStatusLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileActiveStatusFont
		lable.text = "online"
		lable.numberOfLines = 0
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var messageButton: UIButton = {
		let button = UIButton()
		button.setTitle("Сообщение", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	private(set) lazy var callButton: UIButton = {
		let button = UIButton()
		button.setTitle("Звонок", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	private(set) lazy var buttonsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 10.0
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private(set) lazy var iconsAndLablesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private(set) lazy var inFriendButton: IconsUIButton = {
		let button = IconsUIButton(with: IconsButtonViewModel(iconTitleLable: "В друзьях", iconeImageView: "confirmIcone"))
		button.translatesAutoresizingMaskIntoConstraints = false
		button.paddingButtonConstant = 5.0
		return button
	}()

	private(set) lazy var moneyButton: IconsUIButton = {
		let button = IconsUIButton(with: IconsButtonViewModel(iconTitleLable: "Деньги", iconeImageView: "payIcone"))
		button.translatesAutoresizingMaskIntoConstraints = false
		button.paddingButtonConstant = 5.0
		return button
	}()

	private(set) lazy var giftButton: IconsUIButton = {
		let button = IconsUIButton(with: IconsButtonViewModel(iconTitleLable: "Подарок", iconeImageView: "giftIcone"))
		button.translatesAutoresizingMaskIntoConstraints = false
		button.paddingButtonConstant = 5.0
		return button
	}()

	private(set) lazy var notificationButton: IconsUIButton = {
		let button = IconsUIButton(with: IconsButtonViewModel(iconTitleLable: "Уведомления", iconeImageView: "bellIcone"))
		button.translatesAutoresizingMaskIntoConstraints = false
		button.paddingButtonConstant = 5.0
		return button
	}()

	private func setupCellCorol() {
		profileActiveStatusLabel.textColor = UIColor.vkGreyText
		messageButton.backgroundColor = UIColor.vkButtonBlue
		messageButton.setTitleColor(UIColor.white, for: .normal)
		callButton.backgroundColor = UIColor.vkButtonBlue
		callButton.setTitleColor(UIColor.white, for: .normal)
		profileNameLabel.textColor = UIColor.vkBlackText
	}

	private func additionStackView() {
		buttonsStackView.addArrangedSubview(messageButton)
		buttonsStackView.addArrangedSubview(callButton)
		iconsAndLablesStackView.addArrangedSubview(inFriendButton)
		iconsAndLablesStackView.addArrangedSubview(moneyButton)
		iconsAndLablesStackView.addArrangedSubview(giftButton)
		iconsAndLablesStackView.addArrangedSubview(notificationButton)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(profileNameLabel)
		contentView.addSubview(avatarImageView)
		contentView.addSubview(profileActiveStatusLabel)
		contentView.addSubview(buttonsStackView)
		contentView.addSubview(iconsAndLablesStackView)
		additionStackView()
		setupCellCorol()
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	func configureCell(friendsViewModel: FriendsViewModel) {
		profileNameLabel.text = friendsViewModel.nameLable
		if friendsViewModel.online == 0 {
			profileActiveStatusLabel.text = "был час назад"
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standartIndent),
			avatarImageView.widthAnchor.constraint(equalToConstant: avatarWidthHeight),
			avatarImageView.heightAnchor.constraint(equalToConstant: avatarWidthHeight),
			avatarImageView.bottomAnchor.constraint(equalTo: self.messageButton.topAnchor, constant: -standartIndent),

			profileNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textIndent),
			profileNameLabel.centerYAnchor.constraint(equalTo: self.avatarImageView.centerYAnchor, constant: -standartIndent),
			profileNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: textMultiplier),

			profileActiveStatusLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textIndent),
			profileActiveStatusLabel.centerYAnchor.constraint(equalTo: self.avatarImageView.centerYAnchor, constant: onlineIndent),
			profileActiveStatusLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: textMultiplier),

			buttonsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			buttonsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -standartIndent),
			buttonsStackView.heightAnchor.constraint(equalToConstant: buttonHeight),
			buttonsStackView.bottomAnchor.constraint(equalTo: self.iconsAndLablesStackView.topAnchor),

			iconsAndLablesStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			iconsAndLablesStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -standartIndent),
			iconsAndLablesStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -bottomIndent)
		])
	}
}
