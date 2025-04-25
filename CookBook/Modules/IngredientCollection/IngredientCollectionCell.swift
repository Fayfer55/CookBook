//
//  IngredientCollectionCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class IngredientCollectionCell: UICollectionViewCell, ClassIdentifiable {
    
    // MARK: - UI Elements
    
    private lazy var titleLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        directionalLayoutMargins = .safeArea
        contentView.addSubview(titleLabel)
        backgroundConfiguration = .listCell()
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.margins)
        }
    }
    
}

// MARK: - Configure

extension IngredientCollectionCell {
    
    func configure(with ingredient: Ingredient) {
        titleLabel.text = ingredient.name
    }
    
}
