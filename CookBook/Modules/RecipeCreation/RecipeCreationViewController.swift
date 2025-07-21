//
//  RecipeCreationViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class RecipeCreationViewController: UIViewController {
    
    private lazy var presenter = RecipeCreationPresenter(view: self)
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("method unavailable")
    }
    
    override func loadView() {
        view = RecipeCreationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Recipe"
        view.backgroundColor = .systemBackground
    }
    
}
