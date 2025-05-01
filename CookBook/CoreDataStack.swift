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
    static let name = "CookBook"

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
        if AppEnvironment.shared.useInMemoryCoreData {
            let bundle = Bundle(for: type(of: self))
            guard let modelURL = bundle.url(forResource: CoreDataStack.name, withExtension: "momd"),
                  let model = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Failed to find CookBook model")
            }
            persistentContainer = NSPersistentContainer(name: CoreDataStack.name, managedObjectModel: model)
            
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentContainer.persistentStoreDescriptions = [description]
        } else {
            persistentContainer = NSPersistentContainer(name: "CookBook")
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
