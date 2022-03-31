//
//  ImageForNewsParser.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.03.2022.
//

import UIKit

final class ImageForNewsParser {

	private var photoTypeP: String = "p"

	private var photoTypeQ: String = "q"

	public func getImg(from newItem: NewsItem) -> String? {

		var wallImg: String = "https://via.placeholder.com/150x150"

		if let attachments = newItem.attachments {

			for i in 0...attachments.count - 1 {
				guard attachments[i].photo != nil else { continue }

				attachments[i].photo?.sizes?.forEach({ element in
					if element.type == photoTypeQ {
						if element.url != nil {
							return wallImg = element.url ?? ""
						}
					} else if  element.type == photoTypeP {
						if element.url != nil {
							return wallImg = element.url ?? ""
						}
					}
				})
			}
			return wallImg
		}
		return wallImg
	}
}
