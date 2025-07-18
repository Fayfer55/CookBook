//
//  ContentReusableView.swift
//  CookBook
//
//  Created by Kirill Faifer on 18.07.2025.
//

import UIKit

class ContentReusableView<Content>: UICollectionReusableView where Content: UIView {
    
    /// When you pass a value to this property ReusableView automatically remove all prevoisly added subviews.
    /// Then it calls setup(subview:) method to make constrains equal to superview edges. 
    var contentView: Content? {
        didSet {
            removeAllSubviews()
            let cell = UITableViewCell()
            
            guard let contentView else { return }
            setup(subview: contentView)
        }
    }
    
    // MARK: - Lifecycle
    
    func setup(subview: UIView) {
        addSubview(subview)
        
        makeEdgeConstraints(for: subview)
    }
    
    private func makeEdgeConstraints(for subview: UIView) {
        subview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
