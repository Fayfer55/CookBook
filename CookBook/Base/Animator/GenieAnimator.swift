//
//  GenieAnimator.swift
//  CookBook
//
//  Created by Kirill Faifer on 14.06.2025.
//

import UIKit

final class GenieAnimator: NSObject {
    
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
}

// MARK: - UIViewControllerAnimatedTransitioning

extension GenieAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval { 0.5 }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView

        if isPresenting {
            let toVC = transitionContext.viewController(forKey: .to)!
            let toView = toVC.view!
            toView.alpha = 0
            container.addSubview(toView)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.alpha = 1
            }) { _ in
                transitionContext.completeTransition(true)
            }
            
        } else {
            let fromView = transitionContext.view(forKey: .from)!
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.alpha = 0
            }) { _ in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
    
}
