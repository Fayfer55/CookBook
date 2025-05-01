//
//  RecipeCreationModel.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.05.2025.
//

import CoreData

struct RecipeCreationModel: RecipeCreatable {
    
    private(set) var recipe: Recipe
    private let backgroundContext: NSManagedObjectContext
    
    // MARK: - Init
    
    init(backgroundContext: NSManagedObjectContext) {
        self.recipe = Recipe(context: backgroundContext)
        self.backgroundContext = backgroundContext
    }
    
    // MARK: - Helpers
    
    func addTitle(_ title: String) {
        recipe.title = title
    }
    
    func addIngredients(_ ingredients: Set<Ingredient>) {
        recipe.addToIngredients(NSSet(set: ingredients))
    }
    
    @discardableResult
    func addStep(title: String, subtitle: String?, tip: String?) -> CookStep {
        let step = CookStep(context: backgroundContext)
        step.number = Int16(recipe.instruction.count + 1)
        step.title = title
        step.subtitle = subtitle
        step.tip = tip
        
        recipe.addToInstruction(step)
        return step
    }
    
    func saveRecipe() throws {
        try CoreDataStack.shared.saveContext(with: backgroundContext)
    }
    
}
