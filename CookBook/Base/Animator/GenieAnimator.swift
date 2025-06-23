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
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval { 0.3 }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView

        if isPresenting {
            guard let presentedView = transitionContext.view(forKey: .to) else { return }
            container.addSubview(presentedView)
            presentedView.transform = .init(scaleX: 0, y: 0)
            presentedView.anchorPoint = .init(x: 0.5, y: 1)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                presentedView.transform = .identity
            }) { _ in
                transitionContext.completeTransition(true)
            }
        } else {
            guard let dismissView = transitionContext.view(forKey: .from) else { return }
            dismissView.anchorPoint = CGPoint(x: 0.5, y: 1)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                dismissView.transform = .init(scaleX: 0.001, y: 0.001)
            }) { _ in
                dismissView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
    
}
