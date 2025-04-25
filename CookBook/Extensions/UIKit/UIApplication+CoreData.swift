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
    
}
