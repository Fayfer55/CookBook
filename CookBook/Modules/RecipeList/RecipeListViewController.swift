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
    
    private let storage: CoreDataContextStorage
    
    private let request: NSFetchRequest<Recipe> = {
        let request = Recipe.fetchRequest()
        request.sortDescriptors = []
        return request
    }()
    
    private lazy var fetchedResultController: NSFetchedResultsController = {
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: storage.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        return controller
    }()
        
    private lazy var dataSource = UITableViewDiffableDataSource<String, NSManagedObjectID>(tableView: tableView) { [unowned self] tableView, indexPath, _ in
        let recipe = fetchedResultController.object(at: indexPath)
        let cell: RecipeListTableCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: recipe.title, subtitle: recipe.subtitle)
        return cell
    }
    
    // MARK: - Lifecycle
    
    init(storage: CoreDataContextStorage) {
        self.storage = storage
        super.init(style: .grouped)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
}

// MARK: - DiffableDataSourceFetchDelegate

extension RecipeListViewController: NSFetchedResultsControllerDelegate {
    
    nonisolated
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let snapshot = snapshot as NSDiffableDataSourceSnapshot<String, NSManagedObjectID>
        
        DispatchQueue.main.async { [weak self] in
            self?.onDataSourceChange?(snapshot.itemIdentifiers.isEmpty)
            self?.dataSource.apply(snapshot)
        }
    }
    
}

// MARK: - UITableViewDelegate

extension RecipeListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = fetchedResultController.object(at: indexPath)
        let viewController = RecipeViewController(recipe: recipe)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [unowned self] _, _, _ in
            let id = fetchedResultController.object(at: indexPath).objectID
            storage.delete(objectID: id)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
