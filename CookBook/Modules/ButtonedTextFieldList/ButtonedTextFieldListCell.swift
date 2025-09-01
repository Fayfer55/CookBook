//
//  ButtonedTextFieldListCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 28.08.2025.
//

import UIKit

class ButtonedTextFieldListCell: UITableViewCell, ReuseIdentifiable {
    
    // MARK: - UI Elements
    
    lazy var textField = ButtonedTextField()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupParentView()
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupParentView() {
        contentView.directionalLayoutMargins = .safeArea
        contentView.backgroundColor = .systemBackground
    }
    
    func setupSubviews() {
        contentView.addSubview(textField)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        textField.snp.makeConstraints {
            $0.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }

}
