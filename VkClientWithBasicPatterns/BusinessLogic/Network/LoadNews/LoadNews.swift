//
//  LoadNews.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.03.2022.
//

import Foundation
import Alamofire

class LoadNews: AbstractRequestFactory, LoadNewsService {

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

	func loadNews(completionHandler: @escaping (AFDataResponse<NewsResponse>) -> Void) {
		let requestModel = LoadNewsRequest(
			baseUrl: baseUrl
		)
		self.request(request: requestModel, completionHandler: completionHandler)
	}

	struct LoadNewsRequest: RequestRouter {
		let baseUrl: URL
		let method: HTTPMethod = .get
		let path: String = "/method/newsfeed.get"
		var parameters: Parameters? {[
			"access_token": UserSettings.shared.token,
			"filters": "post,photo",
			"user_id": UserSettings.shared.userId,
			"v": "5.131"
		]}
	}
}
