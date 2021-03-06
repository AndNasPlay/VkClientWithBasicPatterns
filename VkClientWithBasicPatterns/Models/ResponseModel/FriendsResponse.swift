//
//  FriendsResponse.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.09.2021.
//

import Foundation

struct FriendsResponse: Codable {
	let response: FriendsCountAndItems?
}

struct FriendsCountAndItems: Codable {
	let count: Int?
	let items: [FriendsResult]?
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
	let photo100: String?
	let online: Int?
	let followersCount: Int?
	let university: Int?
	let universityName: String?
	let faculty: Int?
	let facultyName: String?
	let graduation: Int?

	enum CodingKeys: String, CodingKey {
		case id, domain, city, university, faculty, graduation, online
		case universityName = "university_name"
		case facultyName = "faculty_name"
		case followersCount = "followers_count"
		case photo100 = "photo_100"
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
