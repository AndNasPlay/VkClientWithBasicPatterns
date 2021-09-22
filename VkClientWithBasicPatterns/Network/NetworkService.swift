//
//  NetworkService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import Foundation
import Alamofire

class NetworkService {

	static let session: Alamofire.Session = {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 20
		let session = Alamofire.Session(configuration: configuration)
		return session
	}()

	static func loadGroups(token: String) {
		let baseUrl = "https://api.vk.com"
		let path = "/method/groups.get"
		let params: Parameters = [
			"access_token": token,
			"extended": 1,
			"v": "5.131"
		]

		NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
			guard let json = response.value else { return }
			print(json)
		}
	}
}
