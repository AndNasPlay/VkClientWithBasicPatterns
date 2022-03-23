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

	var token: String = "3ea4d3c43ea4d3c43ea4d3c4ed3ed7aeb133ea43ea4d3c4619c285a9b4e3a48cc7c1742"
	var userId: Int = 0
	var baseUrl = URL(string: "https://api.vk.com")!
}
