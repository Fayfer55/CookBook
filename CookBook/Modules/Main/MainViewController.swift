//
//  MainViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit
import CoreData

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let context: NSManagedObjectContext
    
    // MARK: - UI Elements
    
    private lazy var recipesListViewController = RecipeListViewController(context: context)
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "There are no recipes yet"
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
        
        recipesListViewController.performCoreDataRequest()
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
    
    // MARK: - Actions
    
    @objc
    private func createRecipeButtonAction() {
        let context = CoreDataStack.shared.newBackgroundContext
        do {
            let ingredients = try context.fetch(Ingredient.fetchRequest())
            let model = RecipeCreationModel(backgroundContext: context)
            let viewController = RecipeCreationViewController(model: model, ingredients: ingredients)
            navigationController?.pushViewController(viewController, animated: true)
        } catch {
            print(error)
        }
    }

}
