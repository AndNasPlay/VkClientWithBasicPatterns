//
//  LoadGroups.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation
import Alamofire

class LoadGroups: AbstractRequestFactory, LoadGroupsService {

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

	func loadGroups(count: Int, completionHandler: @escaping (AFDataResponse<GroupsResponse>) -> Void) {
		let requestModel = LoadGroupsRequest(
			baseUrl: baseUrl,
			count: count
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct LoadGroupsRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "/method/groups.get"
		let count: Int
		var parameters: Parameters? {[
			"access_token": UserSettings.token,
			"user_id": UserSettings.userId,
			"extended": 1,
			"v": "5.181",
			"fields": "activity",
			"count": "\(count)"
		]}
	}
}
