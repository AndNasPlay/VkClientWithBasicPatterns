//
//  LoaderView.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.03.2022.
//

import UIKit

final class LoaderView: UIView {

	private(set) lazy var viewWidthHeight: CGFloat = 20.0
	private(set) lazy var firstView = UIView()
	private(set) lazy var secondView = UIView()
	private(set) lazy var theThirdView = UIView()
	private var dotSize: CGSize
	private var dotColor: UIColor

	// MARK: - Init

	init(frame: CGRect = .zero, dotSize: CGSize, dotColor: UIColor) {
		self.dotSize = dotSize
		self.dotColor = dotColor
		super.init(frame: frame)

		setupUI()
	}

	@available(*, unavailable)
	public required init?(coder aDecoder: NSCoder) {
		 fatalError("init(coder:) has not been implemented")
	}

	// MARK: - UI

	func setupUI() {
		addSubview(firstView)
		addSubview(secondView)
		addSubview(theThirdView)

		[firstView, secondView, theThirdView].forEach {
			$0.backgroundColor = dotColor
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.widthAnchor.constraint(equalToConstant: dotSize.width).isActive = true
			$0.heightAnchor.constraint(equalToConstant: dotSize.height).isActive = true
			$0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
			$0.clipsToBounds = true
			$0.layer.cornerRadius = dotSize.width / 2
		}

		secondView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		firstView.rightAnchor.constraint(equalTo: secondView.leftAnchor, constant: -15).isActive = true
		theThirdView.leftAnchor.constraint(equalTo: secondView.rightAnchor, constant: 15).isActive = true
	}
}
