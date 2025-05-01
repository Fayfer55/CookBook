//
//  RecipeCreationViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class RecipeCreationViewController: UIViewController {
    
    private let viewModel: RecipeCreatable
    
    // MARK: - UI Elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Recipe name"
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return textField
    }()
    
    private var ingredientsCollection: IngredientCollectionViewController
    
    private lazy var instructionViewController = InstructionListViewController()
    
    private lazy var addStepButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Step", for: .normal)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.configuration = .borderless()
        button.addTarget(self, action: #selector(addStep), for: .touchUpInside)
        button.directionalLayoutMargins = .safeArea
        return button
    }()
    
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
    
    init(model: RecipeCreatable, ingredients: [Ingredient]) {
        viewModel = model
        self.ingredientsCollection = IngredientCollectionViewController(ingredients: ingredients)
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
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(nameTextField)
        
        addChild(ingredientsCollection)
        addChild(instructionViewController)
        
        scrollView.addSubview(ingredientsCollection.view)
        scrollView.addSubview(instructionViewController.view)
        scrollView.addSubview(addStepButton)
        view.addSubview(createButton)
        
        makeConstraints()
        
        ingredientsCollection.didMove(toParent: self)
        instructionViewController.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(createButton.snp.top)
        }
        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(20)
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide).inset(16)
        }
        ingredientsCollection.view.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide).inset(16)
        }
        addStepButton.snp.makeConstraints {
            $0.top.equalTo(ingredientsCollection.view.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        instructionViewController.view.snp.makeConstraints {
            $0.top.equalTo(addStepButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide).inset(16)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
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
        viewModel.addTitle(nameTextField.text ?? "Some recipe")
        viewModel.addIngredients(ingredientsCollection.selectedIngredients)
        
        do {
            try viewModel.saveRecipe()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
    @objc private func addStep() {
        let alertController = UIAlertController(title: "Write a step instruction", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [unowned self] _ in
            guard let textField = alertController.textFields?.first, let text = textField.text, !text.isEmpty else { return }
            let step = viewModel.addStep(title: text, subtitle: nil, tip: nil)
            self.instructionViewController.add(step: step)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        navigationController?.present(alertController, animated: true)
    }
    
}
