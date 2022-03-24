//
//  UserSettings.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import Foundation

final class UserSettings {

	public static let shared = UserSettings()

	private init() { }

	var token: String = ""
	var userId: Int = 0
	var baseUrl = URL(string: "https://api.vk.com")!
}
