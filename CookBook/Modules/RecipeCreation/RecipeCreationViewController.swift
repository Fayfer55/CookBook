//
//  RecipeCreationViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit
import CoreData

final class RecipeCreationViewController: UIViewController {
    
    let recipe: Recipe
    
    private let ingredients: Set<Ingredient>
    private let backgroundContext: NSManagedObjectContext
    
    // MARK: - UI Elements
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Recipe name"
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return textField
    }()
    
    private lazy var ingredientsCollection = IngredientCollectionViewController(ingredients: ingredients)
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Create", for: .normal)
        button.directionalLayoutMargins = .safeArea
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.addTarget(self, action: #selector(createRecipe), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(ingredients: Set<Ingredient>, backgroundContext: NSManagedObjectContext) {
        self.ingredients = ingredients
        self.backgroundContext = backgroundContext
        self.recipe = Recipe(context: backgroundContext)
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
        
        addChild(ingredientsCollection)
        view.addSubview(ingredientsCollection.view)
        view.addSubview(createButton)
        
        makeConstraints()
        
        ingredientsCollection.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        ingredientsCollection.view.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        createButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func createRecipe() {
        recipe.title = nameTextField.text ?? ""
        
        do {
            try backgroundContext.save()
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
}
