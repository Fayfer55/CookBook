//
//  RecipeListTableCell.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import UIKit

final class RecipeListTableCell: UITableViewCell, ClassIdentifiable {
    
    // MARK: - UI Elements

    private lazy var titleLabel = UILabel()
    
    private lazy var subtitleLabel = UILabel()
    
    private lazy var verticalStack: UIStackView = {
        let view  = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupParentView()
        setupSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        contentView.directionalLayoutMargins = .safeArea
    }
    
    private func setupSubviews() {
        contentView.addSubview(verticalStack)
    }
    
    private func makeConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.edges.equalTo(snp.margins)
        }
    }
    
}

// MARK: - Configure

extension RecipeListTableCell {
    
    func configure(with title: String, subtitle: String?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        subtitleLabel.isHidden = subtitle == nil
    }
    
}
