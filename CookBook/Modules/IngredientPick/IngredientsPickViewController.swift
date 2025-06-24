//
//  IngredientsPickViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.06.2025.
//

import UIKit

final class IngredientsPickViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var ingredientsCollection = IngredientCollectionViewController()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupSubviews()
    }
    
    private func setupSubviews() {
        
    }

}
