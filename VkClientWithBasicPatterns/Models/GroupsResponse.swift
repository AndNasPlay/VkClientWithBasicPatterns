//
//  GroupsResponse.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import Foundation

struct GroupsResponse: Codable {
	let response: GroupsCountAndItems?
}

struct GroupsCountAndItems: Codable {
	let count: Int?
	let items: [GroupResult]?
}

struct GroupResult: Codable {
	let id: Int?
	let name: String?
	let screenName: String?
	let isClosed: Int?
	let type: String?
	let isAdmin: Int?
	let isMember: Int?
	let isAdvertiser: Int?
	let photo50: String?
	let photo100: String?
	let photo200: String?
	let description: String?
	let activity: String?

	enum CodingKeys: String, CodingKey {
		case type, description, id, name, activity
		case screenName = "screen_name"
		case isClosed = "is_closed"
		case isAdmin = "is_admin"
		case isMember = "is_member"
		case isAdvertiser = "is_advertiser"
		case photo50 = "photo_50"
		case photo100 = "photo_100"
		case photo200 = "photo_200"
	}
}
