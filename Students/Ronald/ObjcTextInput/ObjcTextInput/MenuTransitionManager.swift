//
//  MenuTransitionManager.swift
//  Menu
//
//  Created by Mathew Sanders on 9/7/14.
//  Copyright (c) 2014 Mat. All rights reserved.
//

import UIKit

class MenuTransitionManager: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
   
    fileprivate var presenting = false
    fileprivate var interactive = false
    
    fileprivate var enterPanGesture: UIScreenEdgePanGestureRecognizer!
    fileprivate var statusBarBackground: UIView!
    
    @objc var fromViewController: UIViewController! {
        didSet {
            self.enterPanGesture = UIScreenEdgePanGestureRecognizer()
            self.enterPanGesture.addTarget(self, action:#selector(MenuTransitionManager.handleOnstagePan(_:)))
            self.enterPanGesture.edges = UIRectEdge.left
            self.fromViewController.view.addGestureRecognizer(self.enterPanGesture)
        }
    }
    
    fileprivate var exitPanGesture: UIPanGestureRecognizer!
    
    @objc var toViewController: UIViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action:#selector(MenuTransitionManager.handleOffstagePan(_:)))
            self.toViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    @objc func handleOnstagePan(_ pan: UIPanGestureRecognizer){
        // how much distance have we panned in reference to the parent view?
        let translation = pan.translation(in: pan.view!)
        
        // do some math to translate this to a percentage based value
        let d =  translation.y / pan.view!.bounds.width * 0.5
        
        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {
            
        case UIGestureRecognizerState.began:
            // set our interactive flag to true
    //        self.interactive = true
            
            // trigger the start of the transition
            self.fromViewController.performSegue(withIdentifier: "addNameSegue", sender: self)
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
    @objc func handleOffstagePan(_ pan: UIPanGestureRecognizer){
        
        let translation = pan.translation(in: pan.view!)
        let d =  translation.y / pan.view!.bounds.width * -0.5
        
        switch (pan.state) {
            
        case UIGestureRecognizerState.began:
            self.interactive = true
            self.toViewController.performSegue(withIdentifier: "dismissController", sender: self)
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
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView
        
        // create a tuple of our screens
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        // assign references to our menu view controller and the 'bottom' view controller from the tuple
        // remember that our menuViewController will alternate between the from and to view controller depending if we're presenting or dismissing
        let toViewController = !self.presenting ? screens.from as! TIITextFieldViewController : screens.to as! TIITextFieldViewController
        let fromViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let toView = toViewController.view
        let fromView = fromViewController.view
        
        // add the both views to our view controller
        
        container.addSubview(fromView!)
        container.addSubview(toView!)

        
        let duration = self.transitionDuration(using: transitionContext)
        
        toView!.alpha = 0.0
        fromView!.alpha = 1.0
        
        // perform the animation!
        UIView.animate(withDuration: duration,animations: {
                       toView!.alpha = 1.0
        }, completion: { finished in
                transitionContext.completeTransition(true)
        })
    }
    
 /*   func offStage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuControllerInteractive(_ menuViewController: TIITextFieldViewController){
        
        menuViewController.view.alpha = 0
        
        // setup paramaters for 2D transitions for animations
        let offstageOffset  :CGFloat = -200
        
    }*/
    
    func onStageMenuController(_ menuViewController: TIITextFieldViewController){
        // prepare menu to fade in
        menuViewController.view.alpha = 1
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animataor when presenting a viewcontroller
    // rememeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // if our interactive flag is true, return the transition manager object
        // otherwise return nil
        return self.interactive ? self : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
}
