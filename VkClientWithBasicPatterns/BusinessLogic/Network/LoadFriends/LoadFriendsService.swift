//
//  LoadFriendsService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation
import Alamofire

protocol LoadFriendsService {
	func loadFriends(completionHandler: @escaping (AFDataResponse<FriendsResponse>) -> Void)
}
