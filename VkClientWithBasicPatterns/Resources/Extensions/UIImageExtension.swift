//
//  UIImageExtension.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import UIKit

public extension UIImage {

func roundedImage() -> UIImage {
	let imageView = UIImageView(image: self)
	let layer = imageView.layer
	layer.masksToBounds = true
	layer.cornerRadius = imageView.frame.width / 2
	UIGraphicsBeginImageContext(imageView.bounds.size)
	// swiftlint:disable force_unwrapping
	layer.render(in: UIGraphicsGetCurrentContext()!)
	let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return roundedImage!
	// swiftlint:enable force_unwrapping
	}
}
