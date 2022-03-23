//
//  ParentFriendProfileViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 23.03.2022.
//

import UIKit

class ParentFriendProfileViewController: UIViewController, CALayerDelegate {

	let requestFactory: RequestFactory
	let friendProfile: FriendsViewModel

	lazy var headerViewController = FriendProfileViewController(requestFactory: requestFactory,
																friendProfile: friendProfile)

	lazy var wallViewController = WallTableViewController(requestFactory: requestFactory,
														  friendProfile: friendProfile)

	lazy var loader = WallLoader(dotSize: CGSize(width: 20.0, height: 20.0),
								 dotColor: .black)

	// MARK: - CABasicAnimation

	private let firstDotAnimationScale = CABasicAnimation(keyPath: "transform.scale")

	private let secondDotAnimationScale = CABasicAnimation(keyPath: "transform.scale")

	private let theThirdDotAnimationScale = CABasicAnimation(keyPath: "transform.scale")

	private let firstDotAnimationOpacity = CABasicAnimation(keyPath: "opacity")

	private let secondDotAnimationOpacity = CABasicAnimation(keyPath: "opacity")

	private let theThirdDotAnimationOpacity = CABasicAnimation(keyPath: "opacity")

	// swiftlint:disable force_cast
	private var parentFriendProfileView: ParentFriendProfileView {
		self.view as! ParentFriendProfileView
	}
	// swiftlint:enable force_cast

	init(requestFactory: RequestFactory, friendProfile: FriendsViewModel) {
		self.requestFactory = requestFactory
		self.friendProfile = friendProfile
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	override func loadView() {
		self.view = ParentFriendProfileView()
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
		addWallViewController()

	}

	private func addChildViewController() {
		self.addChild(headerViewController)
		self.view.addSubview(headerViewController.view)

		self.headerViewController.didMove(toParent: self)

		headerViewController.view.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			headerViewController.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
			headerViewController.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
			headerViewController.view.heightAnchor.constraint(equalToConstant: 350.0)
		])
	}

	private func addLoader() {
		self.view.addSubview(loader)

		loader.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loader.topAnchor.constraint(equalTo: headerViewController.view.bottomAnchor, constant: 20.0),
			loader.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
			loader.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
			loader.heightAnchor.constraint(equalToConstant: 40.0)
		])
	}

	private func addWallViewController() {
		self.addChild(wallViewController)
		self.view.addSubview(wallViewController.view)

		wallViewController.view.translatesAutoresizingMaskIntoConstraints = false
		self.wallViewController.didMove(toParent: self)
		self.wallViewController.view.isHidden = true

		NSLayoutConstraint.activate([
			wallViewController.view.topAnchor.constraint(equalTo: self.view.subviews[0].bottomAnchor),
			wallViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			wallViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			wallViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
		])

	}

	// MARK: - Animation

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

		[loader.firstView, loader.secondView, loader.theThirdView].forEach {
			$0.layer.removeAllAnimations()
		}

		loader.isHidden = true
		self.wallViewController.view.isHidden = false
	}
}

extension ParentFriendProfileViewController: CAAnimationDelegate {

	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		stopAnimation()
	}
}
