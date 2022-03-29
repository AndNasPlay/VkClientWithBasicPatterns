//
//  PhotoShowViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit
import Kingfisher

class PhotoShowViewController: UIViewController {

	private let imageFinder = ImageForPhotoVCParser()

	private(set) lazy var photoIndex: Int = 0

	private(set) lazy var photoArray: [Photo] = [Photo]()

	private(set) lazy var mainImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		self.view.addSubview(mainImageView)
		self.isModalInPresentation = true
		constraintsInit()
		addSwipeRightGestureRecognizer()
		addSwipeLeftGestureRecognizer()
		addStopGestureRecognizer()
		addSwipeDownGestureRecognizer()
	}

	func addPhotoArray(photo: [Photo], and index: Int) {
		guard (photo.count - 1) >= index else { return }
		self.photoIndex = index
		self.photoArray = photo
		mainImageView.kf.setImage(with: URL(string: imageFinder.getImg(
			from: self.photoArray[photoIndex]) ?? "https://via.placeholder.com/150x150"))
	}

	private func addStopGestureRecognizer() {
		let stopGestureRecognizer = UITapGestureRecognizer(target: self,
															  action: #selector(viewStop(stopGestureRecognizer:)))
		view.isUserInteractionEnabled = true
		view.addGestureRecognizer(stopGestureRecognizer)
	}

	private func addSwipeRightGestureRecognizer() {
		let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
															  action: #selector(viewSwipeRight(swipeGestureRecognizer:)))
		swipeGestureRecognizer.direction = .left
		view.isUserInteractionEnabled = true
		view.addGestureRecognizer(swipeGestureRecognizer)
	}

	private func addSwipeDownGestureRecognizer() {
		let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self,
															  action: #selector(viewSwipeDown(swipeGestureRecognizer:)))
		swipeDownGestureRecognizer.direction = .up
		view.isUserInteractionEnabled = true
		view.addGestureRecognizer(swipeDownGestureRecognizer)
	}

	private func addSwipeLeftGestureRecognizer() {
		let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
															  action: #selector(viewSwipeLeft(swipeGestureRecognizer:)))
		swipeGestureRecognizer.direction = .right
		view.isUserInteractionEnabled = true
		view.addGestureRecognizer(swipeGestureRecognizer)
	}

	@objc func viewStop(stopGestureRecognizer: UITapGestureRecognizer) {
		self.mainImageView.stopAnimating()
		self.mainImageView.layer.removeAllAnimations()
		self.mainImageView.layoutIfNeeded()
	}

	@objc func viewSwipeDown(swipeGestureRecognizer: UITapGestureRecognizer) {

		UIView.animate(withDuration: 2.0,
					   delay: 0.0,
					   options: .curveLinear
		) {
			let translation = CGAffineTransform(translationX: 0, y: -400.0)
			let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
			self.mainImageView.transform = translation.concatenating(scale)
		} completion: { _ in
			self.mainImageView.transform = .identity
			self.navigationController?.popViewController(animated: true)
		}
	}

	@objc func viewSwipeRight(swipeGestureRecognizer: UITapGestureRecognizer) {

		if (self.photoArray.count - 1) > self.photoIndex {

			UIView.animate(withDuration: 1.0,
						   delay: 0.0,
						   options: .curveLinear
			) {
				let animation = CABasicAnimation(keyPath: "transform.scale")
				animation.toValue = 0.9
				animation.duration = 1.0
				self.mainImageView.layer.add(animation, forKey: "transformFront")
				self.mainImageView.transform = CGAffineTransform(translationX: -200.0, y: 0.0)
				self.mainImageView.layer.opacity = 0
			} completion: { _ in
				self.mainImageView.transform = CGAffineTransform(translationX: 200.0, y: 0.0)
				UIView.animate(withDuration: 1.0,
							   delay: 0.0,
							   options: .curveLinear
				) {
					self.photoIndex += 1
					let animation = CABasicAnimation(keyPath: "transform.scale")
					animation.fromValue = 0.9
					animation.toValue = 1.0
					animation.duration = 1.0
					self.mainImageView.layer.add(animation, forKey: "transformBack")
					self.mainImageView.kf.setImage(with: URL(string: self.imageFinder.getImg(
						from: self.photoArray[self.photoIndex]) ?? "https://via.placeholder.com/150x150"))
					self.mainImageView.layer.opacity = 1.0
					self.mainImageView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)

				} completion: { _ in

				}
			}
		}
	}

	@objc func viewSwipeLeft(swipeGestureRecognizer: UITapGestureRecognizer) {
		if (self.photoArray.count - 1) >= self.photoIndex && self.photoIndex > 0 {
			UIView.animate(withDuration: 1.0,
						   delay: 0.0,
						   options: .curveLinear
			) {
				let animation = CABasicAnimation(keyPath: "transform.scale")
				animation.toValue = 0.9
				animation.duration = 1.0
				self.mainImageView.layer.add(animation, forKey: "transformFront")
				self.mainImageView.transform = CGAffineTransform(translationX: 200.0, y: 0.0)
				self.mainImageView.layer.opacity = 0
			} completion: { _ in
				self.mainImageView.transform = CGAffineTransform(translationX: -200.0, y: 0.0)
				UIView.animate(withDuration: 1.0,
							   delay: 0.0,
							   options: .curveLinear
				) {
					self.photoIndex -= 1
					let animation = CABasicAnimation(keyPath: "transform.scale")
					animation.fromValue = 0.9
					animation.toValue = 1.0
					animation.duration = 1.0
					self.mainImageView.layer.add(animation, forKey: "transformBack")
					self.mainImageView.kf.setImage(with: URL(string: self.imageFinder.getImg(
						from: self.photoArray[self.photoIndex]) ?? "https://via.placeholder.com/150x150"))
					self.mainImageView.layer.opacity = 1.0
					self.mainImageView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)

				} completion: { _ in

				}
			}
		}
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([
			mainImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
			mainImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
			mainImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
			mainImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
		])
	}
}
