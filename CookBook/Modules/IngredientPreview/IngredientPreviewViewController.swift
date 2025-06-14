//
//  IngredientPreviewViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 13.06.2025.
//

import UIKit

final class IngredientPreviewViewController: UIViewController {
    
    // MARK: - UIElements
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: .tomato)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(imageView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
