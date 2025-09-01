//
//  IngredientSuggestionPresenter.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.09.2025.
//

import Foundation
import CoreData

final class IngredientSuggestionPresenter {
    
    private(set) var searchedIngredient: Ingredient?
    
    private let storage: CoreDataContextStorage
    
    private let request: NSFetchRequest<Ingredient> = {
        let request = Ingredient.fetchRequest()
        request.sortDescriptors = []
        request.fetchLimit = 3
        return request
    }()
    
    init(storage: CoreDataContextStorage) {
        self.storage = storage
    }
    
    // MARK: - Helpers
    
    func searchIngredient(prompt: String) throws -> String {
        request.predicate = NSPredicate(format: "name BEGINSWITH[c] %@", prompt)
        
        let ingredients = try storage.fetch(request: request)
        
        guard let ingredient = ingredients.first else { throw StorageFetchingError.notFound }
        searchedIngredient = ingredient
        return ingredient.name
    }
    
}
