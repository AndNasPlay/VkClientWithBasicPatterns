//
//  ParentProfileViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 26.03.2022.
//

import UIKit

class ParentProfileViewController: UIViewController {

	let requestFactory: RequestFactory

	lazy var profileViewController = ProfileTableViewController(requestFactory: requestFactory)

	lazy var loader = LoaderView(dotSize: CGSize(width: 20.0, height: 20.0),
								 dotColor: .black)

	// MARK: - CABasicAnimation

	private let firstDotAnimationScale = CABasicAnimation(keyPath: "transform.scale")

	private let secondDotAnimationScale = CABasicAnimation(keyPath: "transform.scale")

	private let theThirdDotAnimationScale = CABasicAnimation(keyPath: "transform.scale")

	private let firstDotAnimationOpacity = CABasicAnimation(keyPath: "opacity")

	private let secondDotAnimationOpacity = CABasicAnimation(keyPath: "opacity")

	private let theThirdDotAnimationOpacity = CABasicAnimation(keyPath: "opacity")

	// swiftlint:disable force_cast
	private var parentProfileView: ParentProfileView {
		self.view as! ParentProfileView
	}
	// swiftlint:enable force_cast

	init(requestFactory: RequestFactory) {
		self.requestFactory = requestFactory
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	override func loadView() {
		self.view = ParentProfileView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		setupAnimation()
		startAnimation()

	}

	// MARK: - Private

	private func configureUI() {
		view.backgroundColor = .white
		self.navigationItem.largeTitleDisplayMode = .never

		addChildViewController()
		addLoader()

	}

	private func addChildViewController() {
		self.addChild(profileViewController)
		self.view.addSubview(profileViewController.view)

		self.profileViewController.didMove(toParent: self)

		profileViewController.view.translatesAutoresizingMaskIntoConstraints = false

		self.profileViewController.view.isHidden = true

		NSLayoutConstraint.activate([
			profileViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			profileViewController.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
			profileViewController.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
			profileViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	private func addLoader() {
		self.view.addSubview(loader)

		loader.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
			loader.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
			loader.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
			loader.heightAnchor.constraint(equalToConstant: 40.0)
		])
	}

	func setupAnimation() {
		[firstDotAnimationScale, secondDotAnimationScale, theThirdDotAnimationScale].forEach {
			$0.autoreverses = true
			$0.duration = 0.5
			$0.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
			$0.isRemovedOnCompletion = false
			$0.toValue = 1.5
			$0.repeatCount = 3
			$0.delegate = self
		}

		[firstDotAnimationOpacity, secondDotAnimationOpacity, theThirdDotAnimationOpacity].forEach {
			$0.autoreverses = true
			$0.duration = 0.5
			$0.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
			$0.isRemovedOnCompletion = true
			$0.toValue = 0.2
			$0.repeatCount = 3
			$0.delegate = self
		}
	}

	public func startAnimation() {

		secondDotAnimationScale.beginTime = CACurrentMediaTime() + 0.25
		theThirdDotAnimationScale.beginTime = CACurrentMediaTime() + 0.5

		secondDotAnimationOpacity.beginTime = CACurrentMediaTime() + 0.25
		theThirdDotAnimationOpacity.beginTime = CACurrentMediaTime() + 0.5

		loader.firstView.layer.add(firstDotAnimationScale, forKey: "ScaleFirstDotAnimation")
		loader.firstView.layer.add(firstDotAnimationOpacity, forKey: "OpacityFirstDotAnimation")

		loader.secondView.layer.add(secondDotAnimationScale, forKey: "ScaleSecondDotAnimation")
		loader.secondView.layer.add(secondDotAnimationOpacity, forKey: "OpacitySecondDotAnimation")

		loader.theThirdView.layer.add(theThirdDotAnimationScale, forKey: "ScaleTheThirdDotAnimation")
		loader.theThirdView.layer.add(theThirdDotAnimationOpacity, forKey: "OpacityTheThirdDotAnimation")

	}

	public func stopAnimation() {

		[self.loader.firstView, self.loader.secondView, self.loader.theThirdView].forEach {
			$0.layer.removeAllAnimations()
		}
		self.title = self.profileViewController.title

		UIView.animate(withDuration: 1.0) {
			self.loader.layer.opacity = 0.0
			self.loader.isHidden = true
			self.profileViewController.view.isHidden = false
			self.profileViewController.view.layer.opacity = 1.0
			self.profileViewController.tableView.reloadData()
		}

	}
}

extension ParentProfileViewController: CAAnimationDelegate {

	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		stopAnimation()
	}
}
