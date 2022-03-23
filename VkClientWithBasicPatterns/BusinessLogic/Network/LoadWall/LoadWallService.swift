//
//  LoadWallService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 21.03.2022.
//

import Foundation
import Alamofire

protocol LoadWallService {
	func loadWall(profileId: Int, completionHandler: @escaping (AFDataResponse<WallResponse>) -> Void)
}
