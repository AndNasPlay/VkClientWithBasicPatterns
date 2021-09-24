//
//  UserSettings.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import Foundation

final class UserSettings {
	static var token: String = ""
	static var userId: Int = 0
	static var baseUrl = URL(string: "https://api.vk.com")!
}
