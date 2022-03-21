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
		let image = wall.copyHistory?.first?.attachments?.first?.link?.url
		return WallViewModel(authorNameLable: authorName,
							 authorDateLable: authorDate,
							 authorAvatarLable: image,
							 wallImg: image,
							 likeCount: likeCount)
	}
}
