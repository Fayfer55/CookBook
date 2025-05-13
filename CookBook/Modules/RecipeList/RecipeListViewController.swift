//
//  RecipeListViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import UIKit
import CoreData

final class RecipeListViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var onDataSourceChange: ((Bool) -> Void)?
    
    private let viewModel: CoreDataFetchModel<Recipe>
        
    private lazy var dataSource = UITableViewDiffableDataSource<String, NSManagedObjectID>(tableView: tableView) { [unowned self] tableView, indexPath, objectID in
        guard let recipe = try? self.viewModel.context.existingObject(with: objectID) as? Recipe else {
            fatalError("Recipe should exist") // TODO: - handle error
        }
        let cell: RecipeListTableCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: recipe.title, subtitle: recipe.subtitle)
        return cell
    }
    
    // MARK: - Lifecycle
    
    init(model: CoreDataFetchModel<Recipe>) {
        viewModel = model
        super.init(style: .grouped)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupParentView()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        tableView.register(cellType: RecipeListTableCell.self)
    }
    
}

// MARK: - Helpers

extension RecipeListViewController {
    
    func requestRecipes(onCompletion: @escaping (Bool) -> Void) {
        do {
            onDataSourceChange = onCompletion
            try viewModel.fetchRequest()
        } catch {
            print(error)
        }
    }
    
}

// MARK: - DiffableDataSourceFetchDelegate

extension RecipeListViewController: DiffableDataSourceFetchDelegate {
    
    nonisolated
    func dataSource(didChangeWith snapshot: NSDiffableDataSourceSnapshot<String, NSManagedObjectID>) {
        DispatchQueue.main.async { [weak self] in
            self?.onDataSourceChange?(snapshot.itemIdentifiers.isEmpty)
            self?.dataSource.apply(snapshot)
        }
    }
    
}
