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
    
    private let mainContext: NSManagedObjectContext
    private var request = Recipe.fetchRequest()
    
    private lazy var fetchedResultController: NSFetchedResultsController<Recipe> = {
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mainContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    // MARK: - Init
    
    init(mainContext: NSManagedObjectContext) {
        self.mainContext = mainContext
    }
    
    // MARK: - Helpers
    
    func fetchRequest() {
        do {
            request.sortDescriptors = []
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension RecipeListCoreDataModel: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
        delegate?.dataSource(didChangeWith: snapshot)
    }
    
}
