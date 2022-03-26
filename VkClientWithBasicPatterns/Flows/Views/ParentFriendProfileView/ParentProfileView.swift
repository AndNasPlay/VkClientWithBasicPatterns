//
//  ParentProfileView.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit

final class ParentProfileView: UIView {

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureUI()
	}

	// MARK: - UI

	private func configureUI() {
		self.backgroundColor = .white
	}
}
