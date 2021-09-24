//
//  AbstractErrorParser.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation

protocol AbstractErrorParser {
	func parse(_ result: Error) -> Error
	func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
