//
//  ProfileViewModelFactory.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 29.09.2021.
//

import UIKit

class ProfileViewModelFactory {

	func constructViewModel(from profile: Profile) -> ProfileViewModel {
		getViewModel(from: profile)
	}

	private func getViewModel(from profile: Profile) -> ProfileViewModel {
		let fullName = "\(profile.firstName ?? "Павел") \(profile.lastName ?? "Дуров")"
		let city = "Город: \(profile.city?.title ?? "Москва")"

		return ProfileViewModel(name: fullName, homeTown: city)
	}
}
