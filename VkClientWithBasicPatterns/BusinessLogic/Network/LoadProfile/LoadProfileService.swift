//
//  LoadProfileService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation
import Alamofire

protocol LoadProfileService {
	func loadProfile(completionHandler: @escaping (AFDataResponse<ProfileResponse>) -> Void)
}
