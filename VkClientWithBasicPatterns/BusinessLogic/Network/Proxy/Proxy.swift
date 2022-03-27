//
//  Proxy.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 02.12.2021.
//

import Foundation
import Alamofire

class LoadFriendsServiceLoggingProxy: LoadFriendsService {

	let loadFriendsService: LoadFriendsService

	init( loadFriendsService: LoadFriendsService) {
		self.loadFriendsService = loadFriendsService
	}

	func loadFriends(completionHandler: @escaping (AFDataResponse<FriendsResponse>) -> Void) {
		loadFriendsService.loadFriends(completionHandler: completionHandler)
	}

}
