//
//  ErrorParser.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 24.09.2021.
//

import Foundation

class ErrorParser: AbstractErrorParser {
	func parse(_ result: Error) -> Error {
		result
	}

	func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
		error
	}
}
