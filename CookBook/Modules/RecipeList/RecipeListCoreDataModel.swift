//
//  RecipeListCoreDataModel.swift
//  CookBook
//
//  Created by Kirill Faifer on 15.05.2025.
//

import Foundation
import CoreData

final class RecipeListCoreDataModel: CoreDataFetchModel<Recipe>, RecipeListInterface {
    
    // MARK: - Helpers
    
    func recipe(for indexPath: IndexPath) -> Recipe? {
        fetchedResultController.object(at: indexPath) as? Recipe
    }
    
    func deleteRecipe(at indexPath: IndexPath) {
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
