//
//  LoadWallService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 21.03.2022.
//

import Foundation
import Alamofire

protocol LoadWallService {
	func loadWall(completionHandler: @escaping (AFDataResponse<WallResponse>) -> Void)
}
