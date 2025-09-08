//
//  IngredientTableCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 03.09.2025.
//

import UIKit

final class IngredientTableCell: TextFieldTableCell {
    
    // MARK: - UI Elements
    
    lazy var newIngredientButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        return button
    }()
    
    // MARK: - Layout
    
    override func setupParentView() {
        super.setupParentView()
        
        textField.placeholder = "New ingredient"
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        textField.addSubview(newIngredientButton)
    }
    
    override func makeConstrainsts() {
        textField.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(contentView.snp.bottomMargin)
        }
        newIngredientButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(16)
        }
    }
    
}

// MARK: - Configure

extension IngredientTableCell {
    
    func configure(model: IngredientModel) {
        textField.tag = model.tag
        textField.text = model.text
    }
    
}
