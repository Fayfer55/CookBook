//
//  RecipeListInterface.swift
//  CookBook
//
//  Created by Kirill Faifer on 15.05.2025.
//

import Foundation
import CoreData

protocol RecipeListInterface: AnyObject {
    var delegate: (any DiffableDataSourceFetchDelegate<String, NSManagedObjectID>)? { get set }
    
    func fetchRequest() throws
    func recipe(for indexPath: IndexPath) -> Recipe?
    func deleteRecipe(at indexPath: IndexPath)
}
