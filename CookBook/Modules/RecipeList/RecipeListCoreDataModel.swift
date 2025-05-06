//
//  RecipeListCoreDataModel.swift
//  CookBook
//
//  Created by Kirill Faifer on 06.05.2025.
//

import UIKit
import CoreData

final class RecipeListCoreDataModel: NSObject, DataFetchable {
    
    // MARK: - Proeprties
    
    weak var delegate: (any DiffableDataSourceFetchDelegate<Int, NSManagedObjectID>)?
    
    private(set) lazy var fetchedResultController: NSFetchedResultsController<Recipe> = {
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    private let context: NSManagedObjectContext
    private var request = Recipe.fetchRequest()
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Helpers
    
    func fetchRequest() throws {
        request.sortDescriptors = []
        try fetchedResultController.performFetch()
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension RecipeListCoreDataModel: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
        delegate?.dataSource(didChangeWith: snapshot)
    }
    
}
