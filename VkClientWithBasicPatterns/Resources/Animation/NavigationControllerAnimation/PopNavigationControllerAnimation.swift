//
//  PopNavigationControllerAnimation.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 28.03.2022.
//

import UIKit

class PopNavigationControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		2.0
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

		guard let source = transitionContext.viewController(forKey: .from) else { return }
		guard let destination = transitionContext.viewController(forKey: .to) else { return }

		transitionContext.containerView.addSubview(destination.view)
		transitionContext.containerView.sendSubviewToBack(destination.view)

		destination.view.frame = source.view.frame

		let translation = CGAffineTransform(translationX: -200.0, y: 0)
		let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
		destination.view.transform = translation.concatenating(scale)

		UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
								delay: 0.0,
								options: .calculationModePaced
		) {
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: 0.8) {
				let angleTransform = CGAffineTransform(rotationAngle: -90.0)
				let transform = CGAffineTransform(translationX: -source.view.frame.width / 2, y: source.view.frame.height)
				source.view.transform = transform.concatenating(angleTransform)
			}

			UIView.addKeyframe(withRelativeStartTime: 0.25,
							   relativeDuration: 0.75) {
				destination.view.transform = .identity
			}
		} completion: { finished in
			if finished && !transitionContext.transitionWasCancelled {
				source.removeFromParent()
			} else if transitionContext.transitionWasCancelled {
				destination.view.transform = .identity
			}
			transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
		}
	}
}
