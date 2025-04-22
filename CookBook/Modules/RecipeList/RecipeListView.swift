//
//  RecipeListView.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import UIKit

final class RecipeListView: UIView {
    
    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable) // MARK: - TODO: - research implementaion
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        addSubview(tableView)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
