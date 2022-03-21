//
//  WallResponse.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 21.03.2022.
//

import Foundation

// MARK: - Wall
struct WallResponse: Codable {
	let response: Response?
}

// MARK: - Response
struct Response: Codable {
	let count: Int?
	let items: [WallItem]?
}

// MARK: - Item
struct WallItem: Codable {
	let id, fromID, ownerID, date: Int?
	let postType, text: String?
	let copyHistory: [CopyHistory]?
	let postSource: ItemPostSource?
	let comments: Comments?
	let likes: Likes?
	let reposts: Reposts?
	let views: Views?
	let donut: Donut?
	let shortTextRate: Double?
	let hash: String?

	enum CodingKeys: String, CodingKey {
		case id
		case fromID = "from_id"
		case ownerID = "owner_id"
		case date
		case postType = "post_type"
		case text
		case copyHistory = "copy_history"
		case postSource = "post_source"
		case comments, likes, reposts, views, donut
		case shortTextRate = "short_text_rate"
		case hash
	}
}

// MARK: - Comments
struct Comments: Codable {
	let canPost, count: Int?
	let groupsCanPost: Bool?

	enum CodingKeys: String, CodingKey {
		case canPost = "can_post"
		case count
		case groupsCanPost = "groups_can_post"
	}
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
	let id, ownerID, fromID, date: Int?
	let postType, text: String?
	let attachments: [Attachment]?
	let postSource: CopyHistoryPostSource?

	enum CodingKeys: String, CodingKey {
		case id
		case ownerID = "owner_id"
		case fromID = "from_id"
		case date
		case postType = "post_type"
		case text, attachments
		case postSource = "post_source"
	}
}

// MARK: - Attachment
struct Attachment: Codable {
	let type: String?
	let photo: WallPhoto?
	let link: Link?
}

// MARK: - Link
struct Link: Codable {
	let url: String?
	let title, linkDescription, target: String?

	enum CodingKeys: String, CodingKey {
		case url, title
		case linkDescription = "description"
		case target
	}
}

// MARK: - Photo
struct WallPhoto: Codable {
	let albumID, date, id, ownerID: Int?
	let accessKey: String?
	let sizes: [Size]?
	let text: String?
	let userID: Int?
	let hasTags: Bool?

	enum CodingKeys: String, CodingKey {
		case albumID = "album_id"
		case date, id
		case ownerID = "owner_id"
		case accessKey = "access_key"
		case sizes, text
		case userID = "user_id"
		case hasTags = "has_tags"
	}
}

// MARK: - Size
struct Size: Codable {
	let height: Int?
	let url: String?
	let type: String?
	let width: Int?
}

// MARK: - CopyHistoryPostSource
struct CopyHistoryPostSource: Codable {
	let type: String?
}

// MARK: - Donut
struct Donut: Codable {
	let isDonut: Bool?

	enum CodingKeys: String, CodingKey {
		case isDonut = "is_donut"
	}
}

// MARK: - Likes
struct Likes: Codable {
	let canLike, count, userLikes, canPublish: Int?

	enum CodingKeys: String, CodingKey {
		case canLike = "can_like"
		case count
		case userLikes = "user_likes"
		case canPublish = "can_publish"
	}
}

// MARK: - ItemPostSource
struct ItemPostSource: Codable {
	let platform, type: String?
}

// MARK: - Reposts
struct Reposts: Codable {
	let count, userReposted: Int?

	enum CodingKeys: String, CodingKey {
		case count
		case userReposted = "user_reposted"
	}
}

// MARK: - Views
struct Views: Codable {
	let count: Int?
}
