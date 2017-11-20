//
//  TIITransitionManager.swift
//  
//
//  Created by Naomi De Leeuw on 16/11/2017.
//

import UIKit

@objc class TIITransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    private var presenting = true

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!

        container.addSubview(fromView)
        container.addSubview(toView)

        let duration = self.transitionDuration(using: transitionContext)

        toView.alpha = 0.0

        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1.0
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
}
