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

        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)

        if (self.presenting){
            toView.transform = offScreenRight
           } else {
            toView.transform = offScreenLeft
            }

        container.addSubview(toView)
        container.addSubview(fromView)

        let duration = self.transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseIn, animations: {
            if (self.presenting){
                fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }
            toView.transform = .identity

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
