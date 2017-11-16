//
//  GenieAnimator.swift
//  ObjcTextInput
//
//  Created by Stijn Willems on 16/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import UIKit

// update our class definition to include `UIViewControllerInteractiveTransitioning` as one of the protocols that this object adheres to
class GenieAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {

    private var interactive = true

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    }

    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
    }

    //MARK: - UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }


    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }



    // rest of class definition excluded...
}
