//
//  RequestFactory.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation
import Alamofire

class RequestFactory {

	let baseUrl: URL
	init(baseUrl: URL) {
		self.baseUrl = baseUrl
	}

	func makeErrorParser() -> AbstractErrorParser {
		ErrorParser()
	}

	lazy var commonSession: Session = {
		let configuration = URLSessionConfiguration.default
		configuration.httpShouldSetCookies = false
		configuration.headers = .default
		let manager = Session(configuration: configuration)
		return manager
	}()

	let sessionQueue = DispatchQueue.global(qos: .utility)
	let sessionCallBackQueue = DispatchQueue.main

	func makeLoadFriendsRequestFactory() -> LoadFriendsService {
		let errorParser = makeErrorParser()
		return LoadFriends(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}

	func makeLoadFriendsWithProxyRequestFactory() -> LoadFriendsServiceLoggingProxy {
		LoadFriendsServiceLoggingProxy(loadFriendsService: makeLoadFriendsRequestFactory())

	}

	func makeLoadNewsRequestFactory() -> LoadNewsService {
		let errorParser = makeErrorParser()
		return LoadNews(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}

	func makeLoadGroupsRequestFactory() -> LoadGroupsService {
		let errorParser = makeErrorParser()
		return LoadGroups(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}

	func makeLoadWallRequestFactory() -> LoadWallService {
		let errorParser = makeErrorParser()
		return LoadWall(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}

	func makeLoadProfileRequestFactory() -> LoadProfileService {
		let errorParser = makeErrorParser()
		return LoadProfile(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}

	func makeLoadPhotoRequestFactory() -> LoadPhotoService {
		let errorParser = makeErrorParser()
		return LoadPhoto(
			errorParser: errorParser,
			sessionManager: commonSession,
			queue: sessionCallBackQueue,
			baseUrl: baseUrl
		)
	}
}
