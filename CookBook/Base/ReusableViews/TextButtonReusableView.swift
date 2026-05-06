//
//  TextButtonReusableView.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.06.2025.
//

import UIKit

class TextButtonReusableView: UICollectionReusableView {
    
    // MARK: - UI Elements
    
    lazy var label = UILabel()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setContentHuggingPriority(.required, for: .horizontal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [label, button])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        return view
    }()
    
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
        addSubview(stackView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        
    }
        
}
