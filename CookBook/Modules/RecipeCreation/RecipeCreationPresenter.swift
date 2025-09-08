//
//  RecipeCreationPresenter.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.07.2025.
//

import Foundation
import CoreData.NSManagedObjectID

final class RecipeCreationPresenter {
    
    let storage = CoreDataContextStorageObject(type: .privateQueue, label: "coreData.contextStorage.RecipeCreation.queue")
    
    private(set) var name: String = .empty
    private(set) var ingredients: [String] = [""]
    private(set) var cookSteps: [String] = [""]
    
    // MARK: - Name Helpers
    
    func changeName(_ name: String) {
        self.name = name
    }
    
    // MARK: - Ingredients Helpers
    
    func changeIngredient(name: String, index: Int) {
        if ingredients.indices.contains(index) {
            ingredients[index] = name
        } else {
            ingredients.append(name)
        }
    }
    
    func createEmptyIngredient() {
        ingredients.append(.empty)
    }
    
    // MARK: - CookSteps Helpers
    
    func changeCookStep(text: String, index: Int) {
        if cookSteps.indices.contains(index) {
            cookSteps[index] = text
        } else {
            cookSteps.append(text)
        }
    }
    
    func createEmptyStep() {
        cookSteps.append(.empty)
    }
    
    // MARK: - Recipe Helper
    
    func createRecipe() throws {
        try validateProperties()
        createAndFillRecipe()
        try CoreDataStack.shared.saveContext(with: storage.context)
    }
    
    private func validateProperties() throws {
        guard !name.isEmpty else {
            throw RecipeCreationError.emptyName
        }
        guard !ingredients[.zero].isEmpty else {
            throw RecipeCreationError.emptyIngredients
        }
        guard !cookSteps[.zero].isEmpty else {
            throw RecipeCreationError.emptyCookSteps
        }
    }
    
    private func createAndFillRecipe() {
        let recipe = Recipe(context: storage.context)
        recipe.title = name
        recipe.ingredients = NSSet(array: ingredients.map {
            let ingredient = Ingredient(context: storage.context)
            ingredient.name = $0
            return ingredient
        })
        recipe.instruction = NSOrderedSet(array: cookSteps.map {
            let cookStep = CookStep(context: storage.context)
            cookStep.title = $0
            return cookStep
        })
    }
    
}

enum RecipeCreationError: Error {
    case emptyName, emptyIngredients, emptyCookSteps
}
