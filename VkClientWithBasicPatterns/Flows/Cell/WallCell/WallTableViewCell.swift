//
//  WallTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 21.03.2022.
//

import UIKit
import Kingfisher

class WallTableViewCell: UITableViewCell {

	static let identifier = "WallTableViewCell"

	private(set) lazy var avatarWidthHeight: CGFloat = 25.0

	private(set) lazy var standartIndent: CGFloat = 10.0

	private(set) lazy var cityMultiplier: CGFloat = 0.5

	private(set) lazy var nameMultiplier: CGFloat = 0.7

	private(set) lazy var authorNameLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		return lable
	}()

	private(set) lazy var authorDateCommitLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .lightGray
		lable.font = UIFont.subTitleCellFont
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var authorAvaterImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = avatarWidthHeight / 2
		return imageView
	}()

	private(set) lazy var wallImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private(set) lazy var likeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private(set) lazy var likeCountLable: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		return lable
	}()

	private(set) lazy var likeStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .center
		stack.backgroundColor = .separator
		return stack
	}()

	private(set) lazy var authorStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .center
		return stack
	}()

	private(set) lazy var authorLablesStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .leading
		return stack
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none

		contentView.addSubview(authorStackView)
		authorStackView.addArrangedSubview(authorAvaterImageView)
		authorStackView.addArrangedSubview(authorLablesStackView)
		authorLablesStackView.addArrangedSubview(authorNameLabel)
		authorLablesStackView.addArrangedSubview(authorDateCommitLabel)
		contentView.addSubview(wallImageView)
		contentView.addSubview(likeStackView)
		likeStackView.addArrangedSubview(likeImageView)
		likeStackView.addArrangedSubview(likeCountLable)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

//	func configureCell(wallViewModel: WallViewModel) {
//		authorNameLabel.text = friendsViewModel.nameLable
//		authorDateCommitLabel.text = friendsViewModel.cityName
//		if friendsViewModel.avatarImage != nil {
//			authorAvaterImageView.kf.setImage(with: URL(string: friendsViewModel.avatarImage ?? "http://placehold.it/50x50"))
//		} else {
//			authorAvaterImageView.image = UIImage(named: "testImg")
//		}
//	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([
			authorAvaterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: standartIndent),
			authorAvaterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: standartIndent),
			authorAvaterImageView.widthAnchor.constraint(equalToConstant: avatarWidthHeight),
			authorAvaterImageView.heightAnchor.constraint(equalToConstant: avatarWidthHeight),
			authorAvaterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -standartIndent),

			authorNameLabel.leadingAnchor.constraint(equalTo: self.authorAvaterImageView.trailingAnchor, constant: standartIndent),
			authorNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -standartIndent),
			authorNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: nameMultiplier),

			authorDateCommitLabel.leadingAnchor.constraint(equalTo: self.authorAvaterImageView.trailingAnchor, constant: standartIndent),
			authorDateCommitLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: standartIndent),
			authorDateCommitLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cityMultiplier)
		])
	}

}
