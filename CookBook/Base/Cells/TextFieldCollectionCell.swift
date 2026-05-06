//
//  TextFieldCollectionCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 23.06.2025.
//

import UIKit

class TextFieldCollectionCell: UICollectionViewCell, ReuseIdentifiable {
    
    lazy var textField = UITextField()
    
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
    
    func setupSubviews() {
        contentView.addSubview(textField)
        
        makeConstrainsts()
    }
    
    func makeConstrainsts() {
        
    }
    
}
