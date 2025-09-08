//
//  IngredientSuggestionPresenter.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.09.2025.
//

import Foundation
import CoreData

final class IngredientSuggestionPresenter {
    
    private(set) var suggestion: Ingredient?
    
    private let storage: CoreDataContextStorage
    
    private let request: NSFetchRequest<Ingredient> = {
        let request = Ingredient.fetchRequest()
        request.sortDescriptors = []
        request.fetchLimit = 1
        return request
    }()
    
    // MARK: - Init
    
    init(storage: CoreDataContextStorage) {
        self.storage = storage
    }
    
    // MARK: - Helpers
    
    func searchIngredient(prompt: String) {
        request.predicate = NSPredicate(format: "name BEGINSWITH[c] %@", prompt)
        suggestion = try? storage.fetch(request: request).first
    }
    
}
