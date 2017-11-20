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
    private var presenting = false
    fileprivate let dismiss: () -> Void
    fileprivate let present: () -> Void

   @objc init(dismiss: @escaping () -> Void, present: @escaping () -> Void) {
        self.dismiss = dismiss
        self.present = present
        super.init()
    }

    @objc func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }

    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!

        // set up from 2D transforms that we'll use in the animation
        let π : CGFloat = 3.14159265359

        let offScreenRight = CGAffineTransform(rotationAngle: -π/2)
        let offScreenLeft = CGAffineTransform(rotationAngle: π/2)

        // prepare the toView for the animation
        toView.transform = self.presenting ? offScreenRight : offScreenLeft

        // set the anchor point so that rotations happen from the top-left corner
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)

        // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)

        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)

        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(using: transitionContext)

        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .allowUserInteraction, animations: {

            // slide fromView off either the left or right edge of the screen
            // depending if we're presenting or dismissing this view
            fromView.transform = self.presenting ? offScreenLeft : offScreenRight
            toView.transform = CGAffineTransform.identity

        }, completion: { finished in

            // tell our transitionContext object that we've finished animating
            transitionContext.completeTransition(true)

        })
    }

    @objc override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
    }

    //MARK: - UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning

    @objc func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }


    @objc func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }

}

extension GenieAnimator: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        handleOffstagePan(pan: panGesture)
        return true
    }
    func handleOnstagePan(pan: UIPanGestureRecognizer){
        // how much distance have we panned in reference to the parent view?
        let translation = pan.translation(in: pan.view!)

        // do some math to translate this to a percentage based value
        let d =  translation.x / pan.view!.bounds.size.width * 0.5

        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {

        case UIGestureRecognizerState.began:
            // set our interactive flag to true
            self.interactive = true

            // trigger the start of the transition
            self.present()
            break

        case UIGestureRecognizerState.changed:

            // update progress of the transition
            self.update(d)
            break

        default: // .Ended, .Cancelled, .Failed ...

            // return flag to false and finish the transition
            self.interactive = false
            if(d > 0.2){
                // threshold crossed: finish
                self.finish()
            }
            else {
                // threshold not met: cancel
                self.cancel()
            }
        }
    }

    // pretty much the same as 'handleOnstagePan' except
    // we're panning from right to left
    // perfoming our exitSegeue to start the transition
    func handleOffstagePan(pan: UIPanGestureRecognizer){

        let translation = pan.translation(in: pan.view!)
        let d =  translation.x / pan.view!.bounds.width * -0.5

        switch (pan.state) {

        case UIGestureRecognizerState.began:
            self.interactive = true
            self.dismiss()
            break

        case UIGestureRecognizerState.changed:
            self.update(d)
            break

        default: // .Ended, .Cancelled, .Failed ...
            self.interactive = false
            if(d > 0.1){
                self.finish()
            }
            else {
                self.cancel()
            }
        }
    }
}
