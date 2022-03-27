//
//  PhotoShowViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit

class PhotoShowViewController: UIViewController {

	private(set) lazy var mainImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	func addGestureRecognizer() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		mainImageView.isUserInteractionEnabled = true
		mainImageView.addGestureRecognizer(tapGestureRecognizer)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		self.view.addSubview(mainImageView)
		self.isModalInPresentation = true
		constraintsInit()
		addGestureRecognizer()
	}

	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {

		UIView.animate(withDuration: 0.8,
					   delay: 0.0,
					   options: .autoreverse
		) {
			self.mainImageView.layer.opacity = 0.4
			self.mainImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		} completion: { [weak self] _ in
			self?.mainImageView.transform = .identity
			self?.mainImageView.layer.opacity = 1.0
			self?.dismiss(animated: true, completion: nil)
		}
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([
			mainImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
			mainImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
		])
	}
}
