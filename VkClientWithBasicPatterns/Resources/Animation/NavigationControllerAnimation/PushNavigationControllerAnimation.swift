//
//  PushNavigationControllerAnimation.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 28.03.2022.
//

import UIKit

class PushNavigationControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		2.0
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let source = transitionContext.viewController(forKey: .from) else { return }
		guard let destination = transitionContext.viewController(forKey: .to) else { return }

		transitionContext.containerView.addSubview(destination.view)
		destination.view.frame = source.view.frame
		let angleTransform = CGAffineTransform(rotationAngle: -90.0)
		destination.view.transform = CGAffineTransform(translationX: -source.view.frame.width, y: source.view.frame.height).concatenating(angleTransform)

		UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
								delay: 0.0,
								options: .calculationModePaced
		) {
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: 0.75) {
				let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
				source.view.transform = scale
			}

			UIView.addKeyframe(withRelativeStartTime: 0.2,
							   relativeDuration: 0.4
			) {
				let scale = CGAffineTransform(scaleX: 1.0, y: 1.0)
				destination.view.transform = scale
			}

			UIView.addKeyframe(withRelativeStartTime: 0.9,
							   relativeDuration: 0.4) {
				destination.view.transform = .identity
			}
		} completion: { result in
			if result && !transitionContext.transitionWasCancelled {
				source.view.transform = .identity
				transitionContext.completeTransition(true)
			} else {
				transitionContext.completeTransition(false)
			}
		}
	}
}
