//
//  GridView.swift
//  CookBook
//
//  Created by Kirill Faifer on 30.04.2025.
//

import UIKit

class GridView: UICollectionView {
    
    override var intrinsicContentSize: CGSize {
        collectionViewLayout.collectionViewContentSize
    }
    
    // MARK: - Lifecycle

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        invalidateIntrinsicContentSize()
    }
    
}
