//
//  IconsUIButton.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 01.10.2021.
//

import UIKit

class IconsUIButton: UIButton {

	var heightTitleLable: CGFloat = 15.0
	var paddingButtonConstant: CGFloat = 10.0
	var paddingTopButtonConstant: CGFloat = 20.0
	var iconTitleLableColor = UIColor.vkBlueText

	private(set) lazy var iconTitleLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 1
		lable.textAlignment = .center
		lable.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
		lable.textColor = iconTitleLableColor
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
			iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: paddingTopButtonConstant),
			iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			iconImageView.bottomAnchor.constraint(equalTo: self.iconTitleLable.topAnchor, constant: -paddingButtonConstant),

			iconTitleLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			iconTitleLable.heightAnchor.constraint(equalToConstant: self.heightTitleLable),
			iconTitleLable.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}

struct IconsButtonViewModel {
	let iconTitleLable: String
	let iconeImageView: String
}
