//
//  IngredientButton.swift
//  CookBook
//
//  Created by Kirill Faifer on 23.04.2025.
//

import UIKit

final class IngredientButton: UIButton {
    
    let ingredient: Ingredient
    
    // MARK: - Init
    
    init(ingredient: Ingredient, frame: CGRect = .zero) {
        self.ingredient = ingredient
        super.init(frame: frame)
        
        setupParentView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        configuration = .borderedProminent()
        configuration?.cornerStyle = .capsule
        directionalLayoutMargins = .safeArea
        setTitle(ingredient.name, for: .normal)
    }
    
    @objc
    private func buttonTouchedUpInside() {
//        transform3D =
    }
    
}
