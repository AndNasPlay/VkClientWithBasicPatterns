//
//  ImageForProfileParser.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit

final class ImageForProfileParser {

	private var photoType: String = "o"
	private var photoTypeM: String = "m"

	public func getImg(from profilePhoto: Photo) -> String? {

		var newImg: String = "https://via.placeholder.com/150x150"

		profilePhoto.sizes?.forEach({ element in
			if element.type == photoType {
				if element.url != nil {
					return newImg = element.url ?? ""
				}
			} else if element.type == photoTypeM {
				if element.url != nil {
					return newImg = element.url ?? ""
				}
			}
		})
		return newImg
	}
}
