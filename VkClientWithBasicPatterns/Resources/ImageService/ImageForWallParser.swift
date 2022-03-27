//
//  ImageForWallParser.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.03.2022.
//

import UIKit

final class ImageForWallParser {

	private var photoTypeP: String = "p"

	private var photoTypeQ: String = "q"

	public func getImg(from wallItem: WallItem) -> String? {

		var wallImg: String = "https://via.placeholder.com/150x150"

		if let attachments = wallItem.attachments {

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
		} else if let history = wallItem.copyHistory {
			for i in 0...history.count - 1 {
				guard history[i].attachments?.first != nil else { continue }

				history[i].attachments?.first?.photo?.sizes?.forEach({ element in
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
