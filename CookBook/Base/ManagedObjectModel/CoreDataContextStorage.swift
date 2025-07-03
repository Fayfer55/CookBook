//
//  CoreDataContextStorage.swift
//  CookBook
//
//  Created by Kirill Faifer on 13.05.2025.
//

import Foundation
import CoreData

protocol CoreDataContextStorage: AnyObject {
    var context: NSManagedObjectContext! { get }
    
    func fetch<T: NSManagedObject>() throws -> [T]
    func object<T: NSManagedObject>(with id: NSManagedObjectID) -> T?
    func delete(objectID: NSManagedObjectID)
}

/// This model helps with managing NSManagedObject(fetching, deleting)
nonisolated
final class CoreDataContextStorageObject: NSObject, CoreDataContextStorage, @unchecked Sendable {
    
    // MARK: - Properties

    private(set) var context: NSManagedObjectContext!
    
    private let queue: DispatchQueue
    private let type: NSManagedObjectContext.ConcurrencyType
    
    // MARK: - Lifecycle
    
    init(type: NSManagedObjectContext.ConcurrencyType, label: String) {
        self.type = type
        self.queue = DispatchQueue(label: label)
        super.init()
        
        setupContext()
    }
    
    // MARK: - Helpers
    
    func fetch<T: NSManagedObject>() throws -> [T] {
        switch type {
            case .mainQueue:
                return try fetchObjects()
            default:
                return try queue.sync { [unowned self] in
                    try context.performAndWait { [unowned self] in
                        try fetchObjects()
                    }
                }
        }
    }
    
    func object<T>(with id: NSManagedObjectID) -> T? {
        switch type {
            case .mainQueue:
                return context.object(with: id) as? T
            default:
                return queue.sync { [unowned self] in
                    context.performAndWait { [unowned self] in
                        context.object(with: id) as? T
                    }
                }
        }
    }
    
    func delete(objectID: NSManagedObjectID) {
        switch type {
            case .mainQueue:
                let object = context.object(with: objectID)
                context.delete(object)
                try? CoreDataStack.shared.saveContext()
            default:
                queue.async { [unowned self] in
                    context.perform { [unowned self] in
                        let object = self.context.object(with: objectID)
                        self.context.delete(object)
                        try? CoreDataStack.shared.saveContext(with: self.context)
                    }
                }
        }
    }
    
    // MARK: - Private Helpers
    
    private func setupContext() {
        switch type {
            case .mainQueue:
                context = CoreDataStack.shared.mainContext
            default:
                queue.sync { [unowned self] in
                    context = CoreDataStack.shared.newBackgroundContext
                }
        }
    }
    
    private func fetchObjects<T: NSManagedObject>() throws -> [T] {
        guard let objects = try context.fetch(T.fetchRequest()) as? [T] else {
            throw DecodingError.typeMismatch([T].self, .init(codingPath: [], debugDescription: "Can't cast array of fetched objects to \([T].self)"))
        }
        return objects
    }
    
}
