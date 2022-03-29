//
//  PopPhotoViewControllerAnimation.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 29.03.2022.
//
import UIKit

class PopPhotoViewControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		2.0
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

		guard let source = transitionContext.viewController(forKey: .from) else { return }
		guard let destination = transitionContext.viewController(forKey: .to) else { return }

		transitionContext.containerView.addSubview(destination.view)
		transitionContext.containerView.sendSubviewToBack(destination.view)

		destination.view.frame = source.view.frame

		let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
		source.view.transform = scale

		UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
								delay: 0.0,
								options: .calculationModePaced
		) {
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: 0.8) {
				let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
				source.view.transform = scale
			}

			UIView.addKeyframe(withRelativeStartTime: 0.25,
							   relativeDuration: 0.75) {
				let transform = CGAffineTransform(translationX: 120, y: -150)
				let scale = CGAffineTransform(scaleX: 0.4, y: 0.4)
				source.view.transform = transform.concatenating(scale)
			}
		} completion: { finished in
			destination.view.transform = .identity
			if finished && !transitionContext.transitionWasCancelled {
				source.removeFromParent()
			} else if transitionContext.transitionWasCancelled {
				destination.view.transform = .identity
			}
			transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
		}
	}
}
