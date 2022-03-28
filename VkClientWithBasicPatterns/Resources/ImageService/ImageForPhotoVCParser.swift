//
//  ImageForPhotoVCParser.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 27.03.2022.
//

import UIKit

final class ImageForPhotoVCParser {

	private var photoType: String = "x"
	private var photoTypeY: String = "y"

	public func getImg(from profilePhoto: Photo) -> String? {

		var newImg: String = "https://via.placeholder.com/450x450"

		profilePhoto.sizes?.forEach({ element in
			if element.type == photoType {
				if element.url != nil {
					return newImg = element.url ?? ""
				}
			} else if element.type == photoTypeY {
				if element.url != nil {
					return newImg = element.url ?? ""
				}
			}
		})
		return newImg
	}
}
