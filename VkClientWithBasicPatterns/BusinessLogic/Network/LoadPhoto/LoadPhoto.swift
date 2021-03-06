//
//  LoadPhoto.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 25.09.2021.
//

import Foundation
import Alamofire

class LoadPhoto: AbstractRequestFactory, LoadPhotoService {

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

	func loadPhoto(completionHandler: @escaping (AFDataResponse<PhotoResponse>) -> Void) {
		let requestModel = LoadPhotoRequest(
			baseUrl: baseUrl
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct LoadPhotoRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "/method/photos.get"
		var parameters: Parameters? {[
			"access_token": UserSettings.token,
			"user_id": UserSettings.userId,
			"album_id": "profile",
			"photo_sizes": 1,
			"v": "5.131"
		]}
	}
}
