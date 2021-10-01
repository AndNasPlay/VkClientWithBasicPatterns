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
			iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			iconImageView.bottomAnchor.constraint(equalTo: self.iconTitleLable.topAnchor, constant: -10.0),

			iconTitleLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			iconTitleLable.heightAnchor.constraint(equalToConstant: 20),
			iconTitleLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0)
		])
	}
}

struct IconsButtonViewModel {
	let iconTitleLable: String
	let iconeImageView: String
}
