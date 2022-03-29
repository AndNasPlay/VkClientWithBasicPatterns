//
//  PushPhotoViewControllerAnimation.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 28.03.2022.
//

import UIKit

class PushPhotoViewControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		2.0
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let source = transitionContext.viewController(forKey: .from) else { return }
		guard let destination = transitionContext.viewController(forKey: .to) else { return }

		transitionContext.containerView.addSubview(destination.view)
		destination.view.frame = CGRect(x: 100, y: 200, width: 130, height: 170)

		UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
								delay: 0.0,
								options: .calculationModePaced
		) {
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: 0.75) {
				let sourceScale = CGAffineTransform(scaleX: 0.5, y: 0.5)
				source.view.transform = sourceScale
				destination.view.frame = source.view.frame
			}

			UIView.addKeyframe(withRelativeStartTime: 0.6,
							   relativeDuration: 0.8
			) {
				let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
				destination.view.transform = scale
			}

			UIView.addKeyframe(withRelativeStartTime: 0.6,
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

//	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//		guard let source = transitionContext.viewController(forKey: .from) else { return }
//		guard let destination = transitionContext.viewController(forKey: .to) else { return }
//
//		transitionContext.containerView.addSubview(destination.view)
//		destination.view.frame = source.view.frame
//		destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
//
//		UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
//								delay: 0.0,
//								options: .calculationModePaced
//		) {
//			UIView.addKeyframe(withRelativeStartTime: 0.0,
//							   relativeDuration: 0.75) {
//				let transform = CGAffineTransform(translationX: -200.0, y: 0)
//				let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
//				source.view.transform = transform.concatenating(scale)
//			}
//
//			UIView.addKeyframe(withRelativeStartTime: 0.2,
//							   relativeDuration: 0.4
//			) {
//				let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
//				let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
//				destination.view.transform = translation.concatenating(scale)
//			}
//
//			UIView.addKeyframe(withRelativeStartTime: 0.6,
//							   relativeDuration: 0.4) {
//				destination.view.transform = .identity
//			}
//		} completion: { result in
//			if result && !transitionContext.transitionWasCancelled {
//				source.view.transform = .identity
//				transitionContext.completeTransition(true)
//			} else {
//				transitionContext.completeTransition(false)
//			}
//
//		}
//
//	}
}
