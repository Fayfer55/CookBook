//
//  ManagedObjectModel.swift
//  CookBook
//
//  Created by Kirill Faifer on 13.05.2025.
//

import UIKit
import CoreData

/// This is model helps with managing NSManagedObject(fetching, deleting)
class ManagedObjectModel<T: NSManagedObject>: NSObject {
    
    // MARK: - Properties
    
    let request: NSFetchRequest<any NSFetchRequestResult> = {
        let request = T.fetchRequest()
        request.sortDescriptors = []
        return request
    }()
    
    private(set) lazy var fetchedResultController = NSFetchedResultsController(
        fetchRequest: request,
        managedObjectContext: CoreDataStack.shared.mainContext,
        sectionNameKeyPath: nil,
        cacheName: nil
    )
    
    // MARK: - Helpers
    
    func fetchRequest() throws {
        try? fetchedResultController.performFetch()
    }
    
    func object(for indexPath: IndexPath) -> T? {
        fetchedResultController.object(at: indexPath) as? T
    }
    
    func deleteObject(at indexPath: IndexPath) {
        guard let objectID = (fetchedResultController.object(at: indexPath) as? NSManagedObject)?.objectID else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let context = CoreDataStack.shared.newBackgroundContext
            context.perform {
                let object = context.object(with: objectID)
                context.delete(object)
                
                try? CoreDataStack.shared.saveContext(with: context)
            }
        }
    }
    
}
