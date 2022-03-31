//
//  NewsResponse.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.03.2022.
//

import Foundation

// MARK: - News
struct NewsResponse: Codable {
	let response: ResponseNewsGet?
}

// MARK: - Response
struct ResponseNewsGet: Codable {
	let profiles: [NewsProfile]?
	let items: [NewsItem]?
	let groups: [GroupResult]?
}

// MARK: - Response
struct NewsItem: Codable {
	let type: String?
	let text: String?
	let date: Int?
	let sourceId: Int?
	let comments: NewsComments?
	let likes: NewsLikes?
	let reposts: NewsReposts?
	let attachments: [Attachment]?
	let photos: [NewsPhotos]?

	enum CodingKeys: String, CodingKey {
		case sourceId = "source_id"
		case type, text, date, comments, likes, reposts, attachments, photos
	}
}

// MARK: - Comments
struct NewsComments: Codable {
	let canPost, count: Int?

	enum CodingKeys: String, CodingKey {
		case canPost = "can_post"
		case count
	}
}

// MARK: - Likes
struct NewsLikes: Codable {
	let count: Int?
}

// MARK: - NewsReposts
struct NewsReposts: Codable {
	let count: Int?
}

// MARK: - NewsPhotos
struct NewsPhotos: Codable {
	let id: Int?
	let ownerId: Int?
	let src: String?
	let srcBig: String?

	enum CodingKeys: String, CodingKey {
		case ownerId = "owner_id"
		case srcBig = "src_big"
		case id, src
	}
}

// MARK: - NewsProfile
struct NewsProfile: Codable {
	let firstName: String?
	let lastName: String?
	let maidenName: String?
	let screenName: String?
	let photo50: String?
	let id: Int?

	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
		case maidenName = "maiden_name"
		case screenName = "screen_name"
		case photo50 = "photo_50"
		case id
	}
}
