//
//  WallViewModelFactory.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 21.03.2022.
//

import UIKit

class WallViewModelFactory {

	func constructViewModel(from groups: [WallItem]) -> [WallViewModel] {
		groups.compactMap(getViewModel)
	}

	private var getWallImg = ImageForWallParser()

	private func unixTimeConvertion(unixTime: Double) -> String {

		let date = Date(timeIntervalSince1970: unixTime)
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru")
		dateFormatter.dateStyle = .medium

		return dateFormatter.string(from: date)
	}

	private func getViewModel(from wall: WallItem) -> WallViewModel {

		let authorName = "\(wall.fromID ?? 2)"
		let authorDate = unixTimeConvertion(unixTime: Double(wall.date ?? 0))
		let likeCount = "\(wall.likes?.count ?? 2)"
		let wallText = wall.text ?? ""
		var wallImage: String = ""

		if getWallImg.getImg(from: wall) != nil {
			wallImage = getWallImg.getImg(from: wall) ?? "https://via.placeholder.com/150x150"
		} else {
			wallImage = "https://via.placeholder.com/150x150"
		}

		let avatarImage: String = "https://via.placeholder.com/50x50"

		return WallViewModel(authorNameLable: authorName,
							 authorDateLable: authorDate,
							 authorAvatarImg: avatarImage,
							 wallImg: wallImage,
							 wallText: wallText,
							 likeCount: likeCount
		)
	}
}
