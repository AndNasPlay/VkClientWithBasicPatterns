//
//  Photo.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 25.09.2021.
//

import Foundation

struct PhotoResponse: Codable {
	let response: PhotoItems?
}

struct PhotoItems: Codable {
	let count: Int?
	let items: [Photo]?
}

struct Photo: Codable {
	let id: Int?
	let sizes: [PhotoUrl]?
}

struct PhotoUrl: Codable {
	let url: String?
	let width: Int?
	let height: Int?
	let type: String?
}
