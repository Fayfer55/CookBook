//
//  IngredientPreviewViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 13.06.2025.
//

import UIKit

final class IngredientPreviewViewController: UIViewController {
    
    private let ingredient: Ingredient
    
    // MARK: - Lifecycle
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: .tomato)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
