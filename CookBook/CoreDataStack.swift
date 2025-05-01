//
//  CoreDataStack.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.05.2025.
//

import Foundation
import CoreData

final class CoreDataStack: Sendable {
    
    static let shared = CoreDataStack()

    let persistentContainer: NSPersistentContainer
    
    var newBackgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return context
    }
    
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Init

    private init() {
        persistentContainer = NSPersistentContainer(name: "CookBook")

        if AppEnvironment.shared.useInMemoryCoreData {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentContainer.persistentStoreDescriptions = [description]
        }

        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data setup failed: \(error)")
            }
        }

        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - Helpers
    
    func saveContext(with backgroundContext: NSManagedObjectContext? = nil) throws {
        if let backgroundContext, backgroundContext.hasChanges {
            try backgroundContext.save()
        }
        
        let mainContext = persistentContainer.viewContext
        guard mainContext.hasChanges else { return }
        try mainContext.save()
    }
    
}
