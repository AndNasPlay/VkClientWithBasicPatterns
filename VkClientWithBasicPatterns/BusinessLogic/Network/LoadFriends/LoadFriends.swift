//
//  LoadFriends.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation
import Alamofire

class LoadFriends: AbstractRequestFactory, LoadFriendsService {

	let errorParser: AbstractErrorParser
	let sessionManager: Session
	let queue: DispatchQueue
	let baseUrl: URL
	init(
		errorParser: AbstractErrorParser,
		sessionManager: Session,
		queue: DispatchQueue = DispatchQueue.main,
		baseUrl: URL
	) {
		self.errorParser = errorParser
		self.sessionManager = sessionManager
		self.queue = queue
		self.baseUrl = baseUrl
	}

	func loadFriends(completionHandler: @escaping (AFDataResponse<FriendsResponse>) -> Void) {
		let requestModel = LoadFriendsRequest(
			baseUrl: baseUrl
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct LoadFriendsRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "/method/friends.get"
		var parameters: Parameters? {[
			"access_token": UserSettings.shared.token,
			"user_id": UserSettings.shared.userId,
			"order": "hints",
			"v": "5.181",
			"fields": "city,domain,photo_100,nickname,education,followers_count,online"
		]}
	}
}
