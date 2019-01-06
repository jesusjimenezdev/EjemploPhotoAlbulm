//
//  PresentAnimator.swift
//  PhotoAlbulm
//
//

import Foundation

import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRect.zero
    
    var offset: CGFloat = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.5
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let detailView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let finalFrame = detailView.frame
        
        var initialFrame = originFrame
        
        let detailAspectRatio = finalFrame.width / finalFrame.height
        
        initialFrame.size = CGSize(width: initialFrame.width, height: initialFrame.width / detailAspectRatio)
        
        let scaleFactor = finalFrame.width / initialFrame.width
        
        let growScaleFactor = scaleFactor
        
        let shrinkScaleFactor = 1 / growScaleFactor
        
        detailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
        
        detailView.center = CGPoint(
            x: originFrame.midX,
            y: originFrame.midY + offset
        )
        
        detailView.clipsToBounds = true
        
        containerView.addSubview(detailView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveEaseIn], animations: {
            
            detailView.transform = CGAffineTransform.identity
            
            detailView.center = CGPoint(
                x: finalFrame.midX,
                y: finalFrame.midY
            )
            
        }) { (success) in
            
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
            
        }
        
    }
    
}
