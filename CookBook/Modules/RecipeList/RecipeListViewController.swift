//
//  RecipeListViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import UIKit
import CoreData

final class RecipeListViewController: UITableViewController {
    
    // MARK: - Proeprties
    
    private let context: NSManagedObjectContext
    
    private var request = Recipe.fetchRequest()
    
    private lazy var fetchedResultController: NSFetchedResultsController<Recipe> = {
        let controller = NSFetchedResultsController(
            fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil
        )
        controller.delegate = self
        return controller
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Int, NSManagedObjectID>(tableView: tableView) { [unowned self] tableView, indexPath, objectID in
        guard let recipe = try? self.context.existingObject(with: objectID) as? Recipe else {
            fatalError("Recipe should exist") // TODO: - handle error
        }
        let cell: RecipeListTableCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: recipe.title, subtitle: recipe.subtitle)
        return cell
    }
    
    // MARK: - Lifecycle
    
    init(context: NSManagedObjectContext) {
        self.context = context
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
    
    func performCoreDataRequest() {
        do {
            request.sortDescriptors = []
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

nonisolated
extension RecipeListViewController: NSFetchedResultsControllerDelegate {
    
    func controller(
        _ controller: NSFetchedResultsController<any NSFetchRequestResult>,
        didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference
    ) {
        let snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
        
        print(snapshot.itemIdentifiers.count)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}
