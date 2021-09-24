//
//  Profile.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation

struct Response: Codable {
	let response: Profile?
}

struct Profile: Codable {
	let firstName: String?
	let lastName: String?
	let maidenName: String?
	let screenName: String?
	let relationPending: Int?
	let bdateVisibility: Int?
	let homeTown: String?
	let sex: Int?
	let relation: Int?
	let bdate: String?
	let country: Country?
	let city: City?
	let status: String?
	let phone: String?

	enum CodingKeys: String, CodingKey {
		case sex, relation, bdate, country, city, status, phone
		case firstName = "first_name"
		case lastName = "last_name"
		case maidenName = "maiden_name"
		case screenName = "screen_name"
		case relationPending = "relation_pending"
		case bdateVisibility = "bdate_visibility"
		case homeTown = "home_town"
	}
}

struct Country: Codable {
	let id: Int?
	let title: String?
}
