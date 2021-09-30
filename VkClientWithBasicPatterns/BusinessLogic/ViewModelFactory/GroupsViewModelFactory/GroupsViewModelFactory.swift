//
//  GroupsViewModelFactory.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 29.09.2021.
//

import UIKit

class GroupsViewModelFactory {

	func constructViewModel(from groups: [GroupResult]) -> [GroupsViewModel] {
		groups.compactMap(getViewModel)
	}

	private func getViewModel(from groups: GroupResult) -> GroupsViewModel {
		let groupName = "\(groups.name ?? "Group")"
		let groupActivity = "\(groups.activity ?? "Activity")"
		let avatar = groups.photo50
		return GroupsViewModel(avatarImage: avatar,
							   nameLable: groupName,
							   description: groupActivity)
	}
}
