//
//  UIImageViewExtension.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 29.09.2021.
//

import UIKit

extension UIImageView {
	func setRounded() {
		let radiusImage = self.layer.frame.height / 2.0
		self.layer.cornerRadius = radiusImage
		self.layer.masksToBounds = true
	}
}
