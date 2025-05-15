//
//  MainViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit
import CoreData

final class MainViewController: UIViewController {
    
    enum Accessibility {
        static let emptyLabelIdentifier = "EmptyRecipesLabel"
    }
    
    // MARK: - Properties
    
    private let context: NSManagedObjectContext
    
    // MARK: - UI Elements
    
    private lazy var recipesListViewController: RecipeListViewController = {
        let model = RecipeListCoreDataModel(context: context)
        return RecipeListViewController(model: model)
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "There are no recipes yet"
        label.accessibilityIdentifier = Accessibility.emptyLabelIdentifier
        label.isHidden = true
        return label
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

        configureNavigationBar()
        setupSubviews()
        
        recipesListViewController.requestRecipes(onCompletion: { [weak self] in
            self?.showEmptyLabelIf(isAnyRecipeExists: $0)
        })
    }
    
    // MARK: - Layout
    
    private func configureNavigationBar() {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "document.badge.plus"),
            style: .plain,
            target: self,
            action: #selector(createRecipeButtonAction)
        )
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupSubviews() {
        addChild(recipesListViewController)
        view.addSubview(recipesListViewController.view)
        view.addSubview(emptyLabel)
        
        makeConstraints()
        
        recipesListViewController.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        recipesListViewController.view.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func showEmptyLabelIf(isAnyRecipeExists: Bool) {
        emptyLabel.isHidden = !isAnyRecipeExists
    }
    
    // MARK: - Actions
    
    @objc
    private func createRecipeButtonAction() {
        let model = RecipeCreationCoreDataModel()
        let viewController = RecipeCreationViewController(model: model)
        navigationController?.pushViewController(viewController, animated: true)
    }

}
