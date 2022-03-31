//
//  LoadNewsService.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.03.2022.
//

import Foundation
import Alamofire

protocol LoadNewsService {
	func loadNews(completionHandler: @escaping (AFDataResponse<NewsResponse>) -> Void)
}
