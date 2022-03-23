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

	private(set) lazy var avatarWidthHeight: CGFloat = 50.0

	private(set) lazy var standartIndent: CGFloat = 10.0

	private(set) lazy var cityMultiplier: CGFloat = 0.5

	private(set) lazy var nameMultiplier: CGFloat = 0.7

	private(set) lazy var authorNameLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var authorDateCommitLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .lightGray
		lable.font = UIFont.subTitleCellFont
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var authorAvatarImageView: UIImageView = {
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

	private(set) lazy var likeButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "heart"), for: .normal)
		button.tintColor = .gray
		button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
		button.setTitleColor(.red, for: .selected)
		return button
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
		stack.distribution = .fillProportionally
		stack.layer.cornerRadius = 10.0
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
		stack.spacing = 10.0
		return stack
	}()

	private(set) lazy var authorLablesStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .leading
		stack.spacing = 8.0
		return stack
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none

		contentView.addSubview(authorStackView)
		authorStackView.addArrangedSubview(authorAvatarImageView)
		authorStackView.addArrangedSubview(authorLablesStackView)
		authorLablesStackView.addArrangedSubview(authorNameLabel)
		authorLablesStackView.addArrangedSubview(authorDateCommitLabel)
		contentView.addSubview(wallImageView)
		contentView.addSubview(likeStackView)
		likeStackView.addArrangedSubview(likeButton)
		likeStackView.addArrangedSubview(likeCountLable)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func configureCell(wallViewModel: WallViewModel) {
		authorNameLabel.text = wallViewModel.authorNameLable
		authorDateCommitLabel.text = wallViewModel.authorDateLable
		likeCountLable.text = wallViewModel.likeCount

		if wallViewModel.authorAvatarImg != nil {
			authorAvatarImageView.kf.setImage(with: URL(string: wallViewModel.authorAvatarImg ?? "https://via.placeholder.com/50x50"))
		} else {
			authorAvatarImageView.kf.setImage(with: URL(string: "https://via.placeholder.com/50x50"))
		}

		if wallViewModel.wallImg != nil {
			wallImageView.kf.setImage(with: URL(string: wallViewModel.wallImg ?? "https://via.placeholder.com/300x300"))
		} else {
			wallImageView.kf.setImage(with: URL(string: "https://via.placeholder.com/50x50"))
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([

			authorStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0),
			authorStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0),
			authorStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10.0),
			authorStackView.bottomAnchor.constraint(equalTo: self.wallImageView.topAnchor, constant: -10.0),

			wallImageView.topAnchor.constraint(equalTo: self.authorStackView.bottomAnchor, constant: 10.0),
			wallImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			wallImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			wallImageView.bottomAnchor.constraint(equalTo: self.likeStackView.topAnchor, constant: -10.0),

			likeStackView.topAnchor.constraint(equalTo: self.wallImageView.bottomAnchor, constant: 10.0),
			likeStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0),
			likeStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0),
			likeStackView.widthAnchor.constraint(equalToConstant: 50.0)
		])
	}

}
