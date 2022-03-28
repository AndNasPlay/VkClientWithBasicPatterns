//
//  PhotoCollectionViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit

protocol PhotoCollectionViewCellDelegate: AnyObject {
	func showPhoto(sender: UIImageView)
}

class PhotoCollectionViewCell: UICollectionViewCell {

	static let reuseID = "photoCollectionViewCell"

	weak var delegate: PhotoCollectionViewCellDelegate?

	private(set) lazy var profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10.0
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		addGestureRecognizer()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func addGestureRecognizer() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		profileImageView.isUserInteractionEnabled = true
		profileImageView.addGestureRecognizer(tapGestureRecognizer)
	}

	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		guard let tappedImage = tapGestureRecognizer.view as? UIImageView else { return }
		UIView.animate(withDuration: 0.8,
					   delay: 0.0,
					   options: .autoreverse
		) {
			self.profileImageView.layer.opacity = 0.9
			self.profileImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
		} completion: { [weak self] _ in
			self?.profileImageView.transform = .identity
			self?.profileImageView.layer.opacity = 1.0
			self?.delegate?.showPhoto(sender: tappedImage)
		}
	}

	func setupUI() {
		self.contentView.addSubview(profileImageView)
		self.contentView.backgroundColor = .white

		let photoWidthAnchor = profileImageView.widthAnchor.constraint(equalToConstant: 130.0)
		photoWidthAnchor.priority = .defaultHigh

		let photoHeightAnchor = profileImageView.heightAnchor.constraint(equalToConstant: 170.0)
		photoHeightAnchor.priority = .defaultHigh

		NSLayoutConstraint.activate([

			profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			profileImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			profileImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			profileImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

			photoWidthAnchor,
			photoHeightAnchor
		])
	}

}
