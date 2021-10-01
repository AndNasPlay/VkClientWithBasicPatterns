//
//  IconsUIButton.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 01.10.2021.
//

import UIKit

class IconsUIButton: UIButton {

	private(set) lazy var iconTitleLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 1
		lable.textAlignment = .center
		lable.translatesAutoresizingMaskIntoConstraints = false
		return lable
	}()

	private(set) lazy var iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	let viewModel: IconsButtonViewModel

	init(with viewModel: IconsButtonViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		addSubview(iconTitleLable)
		addSubview(iconImageView)
		configure(with: viewModel)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func configure(with viewModel: IconsButtonViewModel) {
		iconTitleLable.text = viewModel.iconTitleLable
		iconImageView.image = UIImage(named: "\(viewModel.iconeImageView)")
	}

	override func layoutSubviews() {
		NSLayoutConstraint.activate([
			iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
			iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
			iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
			iconImageView.bottomAnchor.constraint(equalTo: iconTitleLable.topAnchor, constant: -10.0),

			iconTitleLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
			iconTitleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10.0),
			iconTitleLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10.0)
		])
	}
}

struct IconsButtonViewModel {
	let iconTitleLable: String
	let iconeImageView: String
}
