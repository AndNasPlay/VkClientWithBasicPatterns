//
//  WallLoaderTableViewCell.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.03.2022.
//

import UIKit

class WallLoaderTableViewCell: UITableViewCell {

	static let identifier = "WallLoaderTableViewCell"

	private(set) lazy var viewWidthHeight: CGFloat = 20.0

	private(set) lazy var firstView: UIView = {
		let newView = UIView()
		newView.backgroundColor = .black
		newView.layer.cornerRadius = viewWidthHeight / 2
		return newView
	}()

	private(set) lazy var secondView: UIView = {
		let newView = UIView()
		newView.backgroundColor = .black
		newView.layer.cornerRadius = viewWidthHeight / 2
		return newView
	}()

	private(set) lazy var theThirdView: UIView = {
		let newView = UIView()
		newView.backgroundColor = .black
		newView.layer.cornerRadius = viewWidthHeight / 2
		return newView
	}()

	private(set) lazy var loaderStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
//		stack.alignment = .center
		stack.spacing = 10.0
		return stack
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = .white
		selectionStyle = UITableViewCell.SelectionStyle.none

		contentView.addSubview(loaderStackView)
		loaderStackView.addArrangedSubview(firstView)
		loaderStackView.addArrangedSubview(secondView)
		loaderStackView.addArrangedSubview(theThirdView)

	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		NSLayoutConstraint.activate([

			loaderStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0),
			loaderStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10.0),
			loaderStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
			loaderStackView.widthAnchor.constraint(equalToConstant: 80.0)

		])
	}

}
