//
//  RecipeCreationCoreDataModel.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.05.2025.
//

import CoreData

struct RecipeCreationCoreDataModel: RecipeCreatable {
    
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
    
    func addTitle(_ title: String) {
        recipe.title = title
    }
    
    func addIngredients(_ ingredients: Set<Ingredient>) {
        recipe.addToIngredients(NSSet(set: ingredients))
    }
    
    @discardableResult
    func addStep(title: String, subtitle: String?, tip: String?) -> CookStep {
        let step = CookStep(context: context)
        step.number = Int16(recipe.instruction.count + 1)
        step.title = title
        step.subtitle = subtitle
        step.tip = tip
        
        recipe.addToInstruction(step)
        return step
    }
    
    func saveRecipe() throws {
        try CoreDataStack.shared.saveContext(with: context)
    }
    
}
