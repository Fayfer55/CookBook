//
//  LabelHeader.swift
//  CookBook
//
//  Created by Kirill Faifer on 03.09.2025.
//

import UIKit

class LabelHeader: UITableViewHeaderFooterView, ReuseIdentifiable {
    
    lazy var label = UILabel()
    
    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setupSubviews() {
        contentView.addSubview(label)
    }
    
    func makeConstraints() {
        
    }
    
}
