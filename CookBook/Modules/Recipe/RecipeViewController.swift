//
//  RecipeViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 14.05.2025.
//

import UIKit

final class RecipeViewController: UIViewController {
    
    let recipe: Recipe
    
    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var ingredientsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Instruction"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var instructionViewController = InstructionListViewController()
    
    // MARK: - Lifecycle
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupParentView()
        setupSubviews()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        navigationItem.title = recipe.title
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        fillSubviewsWithInfo()
        
        view.addSubview(ingredientsLabel)
        view.addSubview(ingredientsStack)
        view.addSubview(instructionLabel)
        
        addChild(instructionViewController)
        view.addSubview(instructionViewController.view)
        
        makeConstraints()
        
        instructionViewController.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        ingredientsLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        ingredientsStack.snp.makeConstraints {
            $0.top.equalTo(ingredientsLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientsStack.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        instructionViewController.view.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func fillSubviewsWithInfo() {
        let ingredients = recipe.ingredients.compactMap { $0 as? Ingredient }
        for ingredient in ingredients {
            let label = UILabel()
            label.text = ingredient.name
            ingredientsStack.addArrangedSubview(label)
        }
        
        let instruction = recipe.instruction.array.compactMap { $0 as? CookStep }
        for step in instruction {
            instructionViewController.add(step: step)
        }
    }

}
