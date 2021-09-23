//
//  Friends.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import Foundation

struct Friends: Codable {
	let response: FriendsCountAndItems?
}

struct FriendsCountAndItems: Codable {
	let count: Int?
	let items: [GroupResult]?
}

struct FriendsResult: Codable {
	let id: Int?
	let firstName: String?
	let lastName: String?
	let canAccessClosed: Bool?
	let isClosed: Bool?
	let domain: String?
	let city: City?
	let canInviteToChats: Bool?
	let trackCode: String?

	enum CodingKeys: String, CodingKey {
		case id, domain, city
		case firstName = "first_name"
		case lastName = "last_name"
		case canAccessClosed = "can_access_closed"
		case isClosed = "is_closed"
		case canInviteToChats = "can_invite_to_chats"
		case trackCode = "track_code"
	}
}

struct City: Codable {
	let id: Int?
	let title: String?
}
