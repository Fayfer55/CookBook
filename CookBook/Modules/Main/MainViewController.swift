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
    
    private let storage = CoreDataContextStorageObject(type: .mainQueue, label: "coreData.contextStorage.MainViewController.queue")
    
    // MARK: - UI Elements
    
    private lazy var recipesListViewController = RecipeListViewController(storage: storage)
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = Localizables.emptyRecipesTitle
        label.accessibilityIdentifier = Accessibility.emptyLabelIdentifier
        label.isHidden = true
        return label
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureTabBarItem()
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
    
    private func configureTabBarItem() {
        let item = UITabBarItem()
        item.image = UIImage(systemName: "book.pages")
        tabBarItem = item
    }
    
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
        let viewController = RecipeCreationViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - Accessibility

extension MainViewController {
    
    enum Accessibility {
        static let emptyLabelIdentifier = "EmptyRecipesLabel"
    }
    
}

// MARK: - Localizables

extension MainViewController {
    
    enum Localizables {
        static let emptyRecipesTitle = String(localized: "mainVC.emptyRecipes.title")
    }
    
}
