//
//  IngredientCollectionCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class IngredientCollectionCell: UICollectionViewCell, ClassIdentifiable {
    
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupParentView()
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard var configuration = backgroundConfiguration?.updated(for: state) else { return }
        
        if state.isSelected {
            configuration.backgroundColor = .systemGreen
        }
        backgroundConfiguration = configuration
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        directionalLayoutMargins = .safeArea
        
        var backgroundConfiguration: UIBackgroundConfiguration = .clear()
        backgroundConfiguration.backgroundColor = .systemBlue
        backgroundConfiguration.cornerRadius = 16
        self.backgroundConfiguration = backgroundConfiguration
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        
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
