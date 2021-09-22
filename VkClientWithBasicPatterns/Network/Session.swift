//
//  Session.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import Foundation

class Session {
	var token: String = ""
	var userId: Int = 0
	static let instanse = Session()
	private init() {}
}
