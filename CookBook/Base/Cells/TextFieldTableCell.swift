//
//  TextFieldTableCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 03.09.2025.
//

import UIKit

class TextFieldTableCell: UITableViewCell, ReuseIdentifiable {
    
    lazy var textField = UITextField()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupParentView()
        setupSubviews()
        makeConstrainsts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setupParentView() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    func setupSubviews() {
        contentView.addSubview(textField)
    }
    
    func makeConstrainsts() {
        textField.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.margins)
        }
    }
    
}
