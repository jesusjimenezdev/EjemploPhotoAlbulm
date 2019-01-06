//
//  DismissAnimator.swift
//  PhotoAlbulm
//
//

import Foundation

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var offset: CGFloat = 0
    
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.2
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let detailView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        let thumbnailView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let finalFrame = originFrame
        
        let initialFrame = detailView.frame
        
        let scaleFactor = initialFrame.width / finalFrame.width
        
        let growScaleFactor = scaleFactor
        
        let shrinkScaleFactor = 1 / growScaleFactor
        
        detailView.clipsToBounds = true
        
        containerView.addSubview(thumbnailView)
        
        containerView.bringSubviewToFront(detailView)
        
        detailView.backgroundColor = UIColor.clear
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [], animations: {
            
            detailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
            
            detailView.center = CGPoint(
                x: finalFrame.midX,
                y: finalFrame.midY + self.offset
            )
            
        }) { (success) in
            
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
            
        }
        
    }
    
    
    
    
}
