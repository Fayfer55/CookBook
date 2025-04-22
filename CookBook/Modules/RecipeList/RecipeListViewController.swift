//
//  RecipeListViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import UIKit

final class RecipeListViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func loadView() {
        view = RecipeListView()
    }
    
}

#Preview {
    RecipeListViewController()
}
