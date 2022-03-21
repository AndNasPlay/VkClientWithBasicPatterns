//
//  LoadWall.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 21.03.2022.
//

import Foundation
import Alamofire

class LoadWall: AbstractRequestFactory, LoadWallService {

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

	func loadWall(completionHandler: @escaping (AFDataResponse<WallResponse>) -> Void) {
		let requestModel = LoadWallRequest(
			baseUrl: baseUrl
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct LoadWallRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "/method/wall.get"
		var parameters: Parameters? {[
			"access_token": UserSettings.shared.token,
			"user_id": UserSettings.shared.userId,
			"count": "2",
			"v": "5.181"
		]}
	}
}
