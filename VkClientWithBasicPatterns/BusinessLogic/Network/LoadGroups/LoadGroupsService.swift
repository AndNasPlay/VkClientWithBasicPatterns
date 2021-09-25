//
//  LoadGroupsService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation
import Alamofire

protocol LoadGroupsService {
	func loadGroups(count: Int, completionHandler: @escaping (AFDataResponse<GroupsResponse>) -> Void)
}
