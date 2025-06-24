//
//  NSCollectionLayoutSize+Static.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.06.2025.
//

import UIKit.UICollectionViewCompositionalLayout

extension NSCollectionLayoutSize {
    
    static let fullSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
    static func fullWidth(forHeight: CGFloat) -> NSCollectionLayoutSize {
        NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(forHeight))
    }
    
}
