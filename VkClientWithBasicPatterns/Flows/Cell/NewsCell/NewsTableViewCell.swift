//
//  NewsTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.03.2022.
//

import UIKit
import Kingfisher

protocol NewsTableViewCellDelegate: AnyObject {
	func addLike(sender: UIButton)
	func showPhoto(sender: UIImageView)
}

class NewsTableViewCell: UITableViewCell {

	static let identifier = "NewsTableViewCell"

	weak var cellDelegate: NewsTableViewCellDelegate?

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

	private(set) lazy var newsImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private(set) lazy var newsTextLable: UILabel = {
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

	private(set) lazy var likeStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.layer.cornerRadius = 10.0
		stack.alignment = .center
		stack.backgroundColor = .lightGray
		return stack
	}()

	private(set) lazy var commentButton: UIButton = {
		let button = UIButton()
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

	private(set) lazy var commentStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.layer.cornerRadius = 10.0
		stack.alignment = .center
		stack.backgroundColor = .lightGray
		return stack
	}()

	private(set) lazy var repostButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
		button.tintColor = .gray
		return button
	}()

	private(set) lazy var repostCountLable: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		return lable
	}()

	private(set) lazy var repostStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.layer.cornerRadius = 10.0
		stack.alignment = .center
		stack.backgroundColor = .lightGray
		return stack
	}()

	private(set) lazy var viewsImageView: UIImageView = {
		let img = UIImageView()
		img.image = UIImage(systemName: "eye.fill")
		img.tintColor = UIColor.gray
		return img
	}()

	private(set) lazy var viewsCountLable: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.titleCellFont
		lable.numberOfLines = 1
		return lable
	}()

	private(set) lazy var viewsStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.layer.cornerRadius = 10.0
		stack.alignment = .center
		stack.spacing = 10.0
		return stack
	}()

	private(set) lazy var itemsStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.spacing = 10.0
		stack.alignment = .center
		stack.backgroundColor = .clear
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
		newsImageView.isUserInteractionEnabled = true
		newsImageView.addGestureRecognizer(tapGestureRecognizer)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none

		addInStackView()

		contentView.addSubview(authorStackView)

		contentView.addSubview(newsTextLable)
		contentView.addSubview(newsImageView)
		contentView.addSubview(itemsStackView)
		contentView.addSubview(viewsStackView)

		likeButton.addTarget(self,
							 action: #selector(handleAddLikeTouchUpInseide),
							 for: .touchUpInside)

		addGestureRecognizer()

	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func addInStackView() {

		authorStackView.addArrangedSubview(authorAvatarImageView)
		authorStackView.addArrangedSubview(authorLablesStackView)

		authorLablesStackView.addArrangedSubview(authorNameLabel)
		authorLablesStackView.addArrangedSubview(authorDateCommitLabel)

		likeStackView.addArrangedSubview(likeButton)
		likeStackView.addArrangedSubview(likeCountLable)

		commentStackView.addArrangedSubview(commentButton)
		commentStackView.addArrangedSubview(commentCountLable)

		repostStackView.addArrangedSubview(repostButton)
		repostStackView.addArrangedSubview(repostCountLable)

		itemsStackView.addArrangedSubview(likeStackView)
		itemsStackView.addArrangedSubview(commentStackView)
		itemsStackView.addArrangedSubview(repostStackView)

		viewsStackView.addArrangedSubview(viewsImageView)
		viewsStackView.addArrangedSubview(viewsCountLable)
	}

	func configureCell(newsViewModel: NewsViewModel) {
		authorNameLabel.text = newsViewModel.authorNameLable
		authorDateCommitLabel.text = newsViewModel.authorDateLable
		likeCountLable.text = newsViewModel.likeCount
		commentCountLable.text = newsViewModel.commentCount
		repostCountLable.text = newsViewModel.repostCount
		newsTextLable.text = newsViewModel.newsText
		viewsCountLable.text = newsViewModel.viewsCount

		if newsViewModel.authorAvatarImg != nil {
			authorAvatarImageView.kf.setImage(with: URL(string: newsViewModel.authorAvatarImg ?? "https://via.placeholder.com/50x50"))
		} else {
			authorAvatarImageView.kf.setImage(with: URL(string: "https://via.placeholder.com/50x50"))
		}

		newsImageView.kf.setImage(with: URL(string: newsViewModel.newsImg ?? "https://via.placeholder.com/300x300"))

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

		let authorStackViewBottomAnchor = authorStackView.bottomAnchor.constraint(equalTo: self.newsTextLable.topAnchor,
																				  constant: -10.0)

		let wallTextLableTopAnchor = newsTextLable.topAnchor.constraint(equalTo: self.authorStackView.bottomAnchor,
																		constant: 10.0)
		let wallTextLableBottomAnchor = newsTextLable.bottomAnchor.constraint(equalTo: self.newsImageView.topAnchor,
																			  constant: -10.0)

		let wallImageViewTopAnchor = newsImageView.topAnchor.constraint(equalTo: self.newsTextLable.bottomAnchor,
																		constant: 10.0)
		let wallImageViewMinHeightAnchor = newsImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150.0)

		authorStackViewBottomAnchor.priority = .defaultHigh
		wallTextLableTopAnchor.priority = .defaultHigh
		wallTextLableBottomAnchor.priority = .defaultHigh
		wallImageViewTopAnchor.priority = .defaultHigh
		wallImageViewMinHeightAnchor.priority = .defaultLow

		NSLayoutConstraint.activate([

			authorStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0),
			authorStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0),
			authorStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10.0),
			authorStackViewBottomAnchor,

			wallTextLableTopAnchor,
			newsTextLable.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0),
			newsTextLable.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10.0),
			wallTextLableBottomAnchor,

			wallImageViewTopAnchor,
			newsImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			newsImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			newsImageView.bottomAnchor.constraint(equalTo: self.itemsStackView.topAnchor, constant: -10.0),
			wallImageViewMinHeightAnchor,

			itemsStackView.topAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: 10.0),
			itemsStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0),
			itemsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0),
			itemsStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 150.0),

			viewsStackView.topAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: 10.0),
			viewsStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10.0),
			viewsStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0),
			viewsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0)
		])
	}

}
