//
//  LoadProfile.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation
import Alamofire

class LoadProfile: AbstractRequestFactory, LoadProfileService {

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

	func loadProfile(completionHandler: @escaping (AFDataResponse<ProfileResponse>) -> Void) {
		let requestModel = LoadProfileRequest(
			baseUrl: baseUrl
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct LoadProfileRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "/method/account.getProfileInfo"
		var parameters: Parameters? {[
			"access_token": UserSettings.token,
			"user_id": UserSettings.userId,
			"v": "5.131"
		]}
	}
}
