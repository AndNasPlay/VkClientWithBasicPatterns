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

	static func loadGroups(token: String) -> [GroupResult] {
		var groupsArr: [GroupResult]?
		let baseUrl = "https://api.vk.com"
		let path = "/method/groups.get"
		let params: Parameters = [
			"access_token": token,
			"extended": 1,
			"v": "5.131"
		]

		NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
			guard let json = response.value else { return }
			let test: Groups = (json as? Groups)!
			groupsArr?.append((test.response?.items?.first)!)
//			let group: Groups = json as? Groups ?? Groups(response: GroupsCountAndItems(count: 1, items: [GroupResult(id: 1, name: "1", screenName: "1", isClosed: 1, type: "1", isAdmin: 1, isMember: 1, isAdvertiser: 1, photo50: "", photo100: "", photo200: "")]))
			print(json)
		}
		return groupsArr!
	}
}
