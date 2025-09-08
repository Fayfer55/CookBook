//
//  CookStepTableCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 05.09.2025.
//

import UIKit

final class CookStepTableCell: TextFieldTableCell {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    // MARK: - Layout
    
    override func setupParentView() {
        super.setupParentView()
        
        textField.placeholder = RecipeCreationViewController.Localizables.cookStepsTextFieldPlaceholder
        textField.returnKeyType = .next
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        contentView.addSubview(numberLabel)
    }
    
    override func makeConstrainsts() {
        numberLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading)
            $0.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints {
            $0.leading.equalTo(numberLabel.snp.trailing).offset(8)
            $0.top.equalTo(contentView.snp.topMargin)
            $0.bottom.equalTo(contentView.snp.bottomMargin)
            $0.trailing.equalTo(contentView.snp.trailingMargin)
        }
    }
    
}

// MARK: - Confugure

extension CookStepTableCell {
    
    func configure(model: CookStepModel) {
        numberLabel.text = String(model.tag + 1) + .dot
        textField.tag = model.tag
        textField.text = model.text
    }
    
}
