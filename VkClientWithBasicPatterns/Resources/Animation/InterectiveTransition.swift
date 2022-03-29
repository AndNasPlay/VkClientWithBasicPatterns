//
//  InterectiveTransition.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 28.03.2022.
//

import UIKit

class InterectiveTransition: UIPercentDrivenInteractiveTransition {

	var hasStarted: Bool = false
	var shouldFinish: Bool = false

	var viewController: UIViewController? {
		didSet {
			let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
			recognizer.edges = [.left]
			viewController?.view.addGestureRecognizer(recognizer)
		}
	}

	@objc func handlePan(_ gesture: UIScreenEdgePanGestureRecognizer) {

		switch gesture.state {
		case .began:

			hasStarted = true
			viewController?.navigationController?.popViewController(animated: true)

		case .changed:

			let translation = gesture.translation(in: gesture.view)
			let relativeTranslation = translation.x / (gesture.view?.bounds.width ?? 1)
			let progress = max(0, min(1, relativeTranslation))
			shouldFinish = progress > 0.33
			update(progress)

		case .ended:

			hasStarted = false
			shouldFinish ? finish() : cancel()

		case .cancelled:

			hasStarted = false
			cancel()

		default:
			return
		}
	}
}
