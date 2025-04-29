//
//  UIApplication+CoreData.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit.UIApplication
import CoreData

extension UIApplication {
    
    static var persistentContainer: NSPersistentContainer {
        (shared.delegate as! AppDelegate).persistentContainer
    }
    
    static var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    static var backgroundContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    static func saveContext() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
