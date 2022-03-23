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

	private func getViewModel(from wall: WallItem) -> WallViewModel {
		let authorName = "\(wall.ownerID ?? 2)"
		let authorDate = "\(wall.date ?? 2)"
		let likeCount = "\(wall.likes?.count ?? 2)"
		let avatarImage: String = "https://via.placeholder.com/50x50"
		var image: String = "https://via.placeholder.com/150x150"

		if let imageSize: Size = (wall.copyHistory?.first?.attachments?.first?.photo?.sizes?.first(where: { $0.type == "r" })) {
			image = imageSize.url ?? "https://via.placeholder.com/150x150"
		}

		return WallViewModel(authorNameLable: authorName,
							 authorDateLable: authorDate,
							 authorAvatarImg: avatarImage,
							 wallImg: image,
							 likeCount: likeCount)
	}
}
