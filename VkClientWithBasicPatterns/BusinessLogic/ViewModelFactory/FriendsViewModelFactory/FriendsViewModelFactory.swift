//
//  FriendsAndGroupsViewModelFactory.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 29.09.2021.
//

import UIKit

class FriendsViewModelFactory {

	func constructViewModel(from friends: [FriendsResult]) -> [FriendsViewModel] {
		friends.compactMap(getViewModel)
	}

	private func getViewModel(from friend: FriendsResult) -> FriendsViewModel {
		let fullName = "\(friend.firstName ?? "Павел") \(friend.lastName ?? "Дуров")"
		let city = friend.city?.title
		let avatar = friend.photo100
		let trackCode = friend.domain
		let online = friend.online
		let education = friend.universityName
		let followersCount = friend.followersCount
		return FriendsViewModel(
			avatarImage: avatar,
			nameLable: fullName,
			cityName: city,
			domain: trackCode,
			online: online,
			education: education,
			followersCount: followersCount
		)
	}
}
