//
//  FramePresentationController.swift
//  CookBook
//
//  Created by Kirill Faifer on 14.06.2025.
//

import UIKit

final class FramePresentationController: UIPresentationController {
    
    private let frame: CGRect
    
    private lazy var dragGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(dragGestureAction))
        return recognizer
    }()
    
    // MARK: - UI Elements
    
    private lazy var systemThinMaterialView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    // MARK: - Lifecycle
    
    init(frame: CGRect, presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.frame = frame
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let size = CGSize(width: 150, height: 150)
        let spacing: CGFloat = 16
        print(frame)
    
        let origin = CGPoint(x: frame.midX - size.width / 2, y: frame.minY - size.height - spacing)
        
        return CGRect(origin: origin, size: size)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        setupParentView()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        presentedView?.frame = frameOfPresentedViewInContainerView
        
        makeSystemThinMaterialBackground()
        let containerPath = UIBezierPath(rect: containerView?.frame ?? .zero)
        let holePath = UIBezierPath(roundedRect: frame, cornerRadius: IngredientCollectionCell.kCornerRadius)
        
        containerPath.append(holePath)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = containerPath.cgPath
        maskLayer.fillRule = .evenOdd

        systemThinMaterialView.layer.mask = maskLayer
    }
    
    private func makeSystemThinMaterialBackground() {
        systemThinMaterialView.frame = containerView?.bounds ?? .zero
        systemThinMaterialView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        systemThinMaterialView.addGestureRecognizer(dragGestureRecognizer)

        containerView?.addSubview(systemThinMaterialView)
        containerView?.bringSubviewToFront(presentedView ?? systemThinMaterialView)
    }
    
    // MARK: - Actions
    
    @objc
    private func dragGestureAction(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: containerView)
        
        systemThinMaterialView.layer.opacity -= Float(translation.y) / 1000
        
        guard systemThinMaterialView.layer.opacity < .zero || systemThinMaterialView.layer.opacity.isZero else { return }
        presentedViewController.dismiss(animated: true)
    }

}
