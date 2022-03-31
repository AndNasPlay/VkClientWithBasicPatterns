//
//  WallTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 21.03.2022.
//

import UIKit
import Kingfisher

protocol WallTableViewCellDelegate: AnyObject {
	func addLike(sender: UIButton)
	func showPhoto(sender: UIImageView)
}

class WallTableViewCell: UITableViewCell {

	static let identifier = "WallTableViewCell"

	weak var cellDelegate: WallTableViewCellDelegate?

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

	private(set) lazy var wallTextLable: UILabel = {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 0
		lable.text = "Текст отсутствует"
		return lable
	}()

	private(set) lazy var likeButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
		button.tintColor = .gray
		return button
	}()

	private(set) lazy var likeCountLable: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		return lable
	}()

	private(set) lazy var commentButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
		button.tintColor = .gray
		return button
	}()

	private(set) lazy var commentCountLable: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		return lable
	}()

	private(set) lazy var viewsButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "message"), for: .normal)
		button.tintColor = .gray
		return button
	}()

	private(set) lazy var viewsCountLable: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		return lable
	}()

	private(set) lazy var itemsStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.layer.cornerRadius = 10.0
		stack.alignment = .center
		stack.backgroundColor = .lightGray
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

	func addGestureRecognizer() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		wallImageView.isUserInteractionEnabled = true
		wallImageView.addGestureRecognizer(tapGestureRecognizer)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none

		contentView.addSubview(authorStackView)

		authorStackView.addArrangedSubview(authorAvatarImageView)
		authorStackView.addArrangedSubview(authorLablesStackView)

		authorLablesStackView.addArrangedSubview(authorNameLabel)
		authorLablesStackView.addArrangedSubview(authorDateCommitLabel)

		contentView.addSubview(wallTextLable)
		contentView.addSubview(wallImageView)
		contentView.addSubview(itemsStackView)

		itemsStackView.addArrangedSubview(likeButton)
		itemsStackView.addArrangedSubview(likeCountLable)
		itemsStackView.addArrangedSubview(commentButton)
		itemsStackView.addArrangedSubview(commentCountLable)
		itemsStackView.addArrangedSubview(viewsButton)
		itemsStackView.addArrangedSubview(viewsCountLable)

		likeButton.addTarget(self,
							 action: #selector(handleAddLikeTouchUpInseide),
							 for: .touchUpInside)

		addGestureRecognizer()

	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func configureCell(wallViewModel: WallViewModel) {
		authorNameLabel.text = wallViewModel.authorNameLable
		authorDateCommitLabel.text = wallViewModel.authorDateLable
		likeCountLable.text = wallViewModel.likeCount
		commentCountLable.text = wallViewModel.commentCount
		viewsCountLable.text = wallViewModel.viewsCount
		wallTextLable.text = wallViewModel.wallText

		if wallViewModel.authorAvatarImg != nil {
			authorAvatarImageView.kf.setImage(with: URL(string: wallViewModel.authorAvatarImg ?? "https://via.placeholder.com/50x50"))
		} else {
			authorAvatarImageView.kf.setImage(with: URL(string: "https://via.placeholder.com/50x50"))
		}

		wallImageView.kf.setImage(with: URL(string: wallViewModel.wallImg ?? "https://via.placeholder.com/300x300"))

	}

	@objc func handleAddLikeTouchUpInseide() {
		cellDelegate?.addLike(sender: likeButton)
	}

	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		guard let tappedImage = tapGestureRecognizer.view as? UIImageView else { return }
		cellDelegate?.showPhoto(sender: tappedImage)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		let authorStackViewBottomAnchor = authorStackView.bottomAnchor.constraint(equalTo: self.wallTextLable.topAnchor,
																				  constant: -10.0)

		let wallTextLableTopAnchor = wallTextLable.topAnchor.constraint(equalTo: self.authorStackView.bottomAnchor,
																		constant: 10.0)
		let wallTextLableBottomAnchor = wallTextLable.bottomAnchor.constraint(equalTo: self.wallImageView.topAnchor,
																			  constant: -10.0)

		let wallImageViewTopAnchor = wallImageView.topAnchor.constraint(equalTo: self.wallTextLable.bottomAnchor,
																		constant: 10.0)
		authorStackViewBottomAnchor.priority = .defaultLow
		wallTextLableTopAnchor.priority = .defaultLow
		wallTextLableBottomAnchor.priority = .defaultLow
		wallImageViewTopAnchor.priority = .defaultLow

		NSLayoutConstraint.activate([

			authorStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0),
			authorStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0),
			authorStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10.0),
			authorStackViewBottomAnchor,

			wallTextLableTopAnchor,
			wallTextLable.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			wallTextLable.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			wallTextLableBottomAnchor,

			wallImageViewTopAnchor,
			wallImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			wallImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			wallImageView.bottomAnchor.constraint(equalTo: self.itemsStackView.topAnchor, constant: -10.0),

			itemsStackView.topAnchor.constraint(equalTo: self.wallImageView.bottomAnchor, constant: 10.0),
			itemsStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0),
			itemsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0),
			itemsStackView.widthAnchor.constraint(equalToConstant: 150.0)
		])
	}

}
