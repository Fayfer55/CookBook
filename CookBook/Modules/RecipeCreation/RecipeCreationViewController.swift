//
//  RecipeCreationViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit
import CoreData

final class RecipeCreationViewController: UIViewController {
    
//    let recipe = Recipe()

    private let context: NSManagedObjectContext
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Recipe name"
        return textField
    }()
    
    // MARK: - Lifecycle
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("method unavailable")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(nameTextField)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}
