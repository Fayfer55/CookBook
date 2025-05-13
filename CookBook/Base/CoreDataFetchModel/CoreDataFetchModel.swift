//
//  CoreDataFetchModel.swift
//  CookBook
//
//  Created by Kirill Faifer on 13.05.2025.
//

import UIKit
import CoreData

/// This is a model for FetchedResultController which excapsulates DiffableDataSourceFetchDelegate & DataFetchable logic
class CoreDataFetchModel<T: NSManagedObject>: NSObject, DataFetchable, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    let context: NSManagedObjectContext
    let request = T.fetchRequest()
    
    weak var delegate: (any DiffableDataSourceFetchDelegate<String, NSManagedObjectID>)?
    
    private(set) lazy var fetchedResultController: NSFetchedResultsController<any NSFetchRequestResult> = {
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        return controller
    }()
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Helpers
    
    func fetchRequest() throws {
        if request.sortDescriptors == nil {
            request.sortDescriptors = []
        }
        try fetchedResultController.performFetch()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let snapshot = snapshot as NSDiffableDataSourceSnapshot<String, NSManagedObjectID>
        delegate?.dataSource(didChangeWith: snapshot)
    }
    
}
