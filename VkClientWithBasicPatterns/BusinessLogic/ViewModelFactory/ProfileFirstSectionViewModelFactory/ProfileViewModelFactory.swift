//
//  ProfileViewModelFactory.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 29.09.2021.
//

import UIKit

class ProfileViewModelFactory {

	func constructViewModel(from profile: Profile) -> ProfileFirstSectionViewModel {
		getViewModel(from: profile)
	}

	private func getViewModel(from profile: Profile) -> ProfileFirstSectionViewModel {
		let fullName = "\(profile.firstName ?? "Павел") \(profile.lastName ?? "Дуров")"
		let city = "Город: \(profile.city?.title ?? "Москва")"

		return ProfileFirstSectionViewModel(name: fullName, homeTown: city)
	}
}
