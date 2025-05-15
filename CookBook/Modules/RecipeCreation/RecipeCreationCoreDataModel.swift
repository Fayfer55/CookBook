//
//  RecipeCreationCoreDataModel.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.05.2025.
//

import CoreData

struct RecipeCreationCoreDataModel: RecipeCreationInterface {
    
    private(set) var recipe: Recipe
    private let context: NSManagedObjectContext
    
    // MARK: - Init
    
    init() {
        context = CoreDataStack.shared.newBackgroundContext
        recipe = Recipe(context: context)
    }
    
    // MARK: - Helpers
    
    func allIngredients() -> [Ingredient] {
        (try? context.fetch(Ingredient.fetchRequest())) ?? []
    }
    
    func nextCookStep() -> CookStep {
        let step = CookStep(context: context)
        step.number = Int16(recipe.instruction.count + 1)
        return step
    }
    
    func saveRecipe() throws {
        try CoreDataStack.shared.saveContext(with: context)
    }
    
}
