//
//  NewsViewModelFactory.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 30.03.2022.
//

import UIKit

class NewsViewModelFactory {

	func constructViewModel(from news: [NewsItem], profiles: [NewsProfile], groups: [GroupResult]) -> [NewsViewModel] {
		var newViewModel: [NewsViewModel] = [NewsViewModel]()
		for i in 0...news.count - 1 {
			newViewModel.append(getViewModel(from: news[i], profiles: profiles, groups: groups))
		}
		return newViewModel
	}

	private var getNewsImg = ImageForNewsParser()

	private func unixTimeConvertion(unixTime: Double) -> String {

		let date = Date(timeIntervalSince1970: unixTime)
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru")
		dateFormatter.dateStyle = .medium

		return dateFormatter.string(from: date)
	}

	private func getViewModel(from news: NewsItem, profiles: [NewsProfile], groups: [GroupResult]) -> NewsViewModel {

		var authorName = "Имя автора"
		var avatarImage: String = "https://via.placeholder.com/50x50"
		let authorDate = unixTimeConvertion(unixTime: Double(news.date ?? 0))
		let likeCount = "\(news.likes?.count ?? 2)"
		let newsText = news.text ?? ""
		var newsImage: String = "0"
		let commentCount = "\(news.comments?.count ?? 0)"
		let viewsCount = "0"
		let reportsCount = "\(news.reposts?.count ?? 0)"

		if getNewsImg.getImg(from: news) != nil {
			newsImage = getNewsImg.getImg(from: news) ?? "https://via.placeholder.com/150x150"
		} else {
			newsImage = "https://via.placeholder.com/150x150"
		}

		if news.sourceId ?? 0 > 0 {

		let	newAuthorName = profiles.first(where: { $0.id == news.sourceId })

			authorName = newAuthorName?.firstName ?? "Имя автора"
			avatarImage = newAuthorName?.photo50 ?? "https://via.placeholder.com/50x50"

		} else {

			let	newAuthorName = groups.first(where: { (-($0.id ?? 0)) == news.sourceId })

			authorName = newAuthorName?.name ?? "Имя автора"
			avatarImage = newAuthorName?.photo50 ?? "https://via.placeholder.com/50x50"
		}

		return NewsViewModel(authorNameLable: authorName,
							 authorDateLable: authorDate,
							 authorAvatarImg: avatarImage,
							 newsImg: newsImage,
							 newsText: newsText,
							 likeCount: likeCount,
							 commentCount: commentCount,
							 viewsCount: viewsCount,
							 repostCount: reportsCount
		)
	}
}
