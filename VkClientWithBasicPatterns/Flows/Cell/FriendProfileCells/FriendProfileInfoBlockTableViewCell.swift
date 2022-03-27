//
//  FriendProfileInfoBlockTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 05.10.2021.
//

import UIKit

class FriendProfileInfoBlockTableViewCell: UITableViewCell {

	static let identifier = "FriendProfileInfoBlockTableViewCell"

	private let lableMultiplier: CGFloat = 0.85

	private let cellStackViewTopAndBottomAnchor: CGFloat = 10.0

	private let cellStackViewLeadingTrailingAnchor: CGFloat = 5.0

	private(set) lazy var cityImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.contentMode = .center
		imageView.image = UIImage(named: "homeInfo")
		return imageView
	}()

	private(set) lazy var cityLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileActiveStatusFont
		lable.text = "city"
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var placeOfStudyImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.contentMode = .center
		imageView.image = UIImage(named: "hatActive")
		return imageView
	}()

	private(set) lazy var placeOfStudyLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileStatusFont
		lable.text = "Указать место учебы"
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var placeOfWorkImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.contentMode = .center
		imageView.image = UIImage(named: "caseActive")
		return imageView
	}()

	private(set) lazy var placeOfWorkLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileStatusFont
		lable.text = "Указать место работы"
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var informationImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.contentMode = .center
		imageView.image = UIImage(named: "informationActive")
		return imageView
	}()

	private(set) lazy var informationLabel: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.profileStatusFont
		lable.text = "Подробная информация"
		lable.numberOfLines = 1
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var cityStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private(set) lazy var placeOfStudyStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private(set) lazy var placeOfWorkStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private(set) lazy var informationStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private(set) lazy var cellStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private func additionStackView() {
		cityStackView.addArrangedSubview(cityImageView)
		cityStackView.addArrangedSubview(cityLabel)

		placeOfStudyStackView.addArrangedSubview(placeOfStudyImageView)
		placeOfStudyStackView.addArrangedSubview(placeOfStudyLabel)

		placeOfWorkStackView.addArrangedSubview(placeOfWorkImageView)
		placeOfWorkStackView.addArrangedSubview(placeOfWorkLabel)

		informationStackView.addArrangedSubview(informationImageView)
		informationStackView.addArrangedSubview(informationLabel)

		cellStackView.addArrangedSubview(cityStackView)
		cellStackView.addArrangedSubview(placeOfStudyStackView)
		cellStackView.addArrangedSubview(placeOfWorkStackView)
		cellStackView.addArrangedSubview(informationStackView)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none
		contentView.addSubview(cellStackView)
		additionStackView()
		setupCellCorol()
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	func configureCell(friendsViewModel: FriendsViewModel) {

		if (friendsViewModel.cityName ?? "").isEmpty {
			cityStackView.isHidden = true
		} else {
			cityLabel.text = "Город: \(friendsViewModel.cityName ?? "")"
		}

		if (friendsViewModel.education ?? "").isEmpty {
			placeOfStudyStackView.isHidden = true
		} else {
			placeOfStudyLabel.text = "Образование: \(friendsViewModel.education ?? "")"
			placeOfStudyImageView.image = UIImage(named: "hat")
			placeOfStudyLabel.textColor = UIColor.vkGreyText
		}

		if (friendsViewModel.followersCount ?? 0) != 0 {
			placeOfWorkLabel.text = "\(friendsViewModel.followersCount ?? 0) подписчик"
			placeOfWorkLabel.textColor = UIColor.vkGreyText
			placeOfWorkImageView.image = UIImage(named: "rss")
		} else {
			placeOfWorkStackView.isHidden = true
		}
	}

	private func setupCellCorol() {
		cityLabel.textColor = UIColor.vkGreyText
		placeOfStudyLabel.textColor = UIColor.vkBlueText
		placeOfWorkLabel.textColor = UIColor.vkBlueText
		informationLabel.textColor = UIColor.vkBlueText
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			cityLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: lableMultiplier),
			placeOfWorkLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: lableMultiplier),
			placeOfStudyLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: lableMultiplier),
			informationLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: lableMultiplier),

			cellStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: cellStackViewTopAndBottomAnchor),
			cellStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: cellStackViewLeadingTrailingAnchor),
			cellStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -cellStackViewLeadingTrailingAnchor),
			cellStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -cellStackViewTopAndBottomAnchor)
		])
	}
}
