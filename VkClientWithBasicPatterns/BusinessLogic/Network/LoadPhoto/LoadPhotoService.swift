//
//  LoadPhotoService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 25.09.2021.
//

import Foundation
import Alamofire

protocol LoadPhotoService {
	func loadPhoto(profileId: Int, completionHandler: @escaping (AFDataResponse<PhotoResponse>) -> Void)
}
