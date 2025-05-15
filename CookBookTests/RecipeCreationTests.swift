//
//  RecipeCreationTests.swift
//  RecipeCreationTests
//
//  Created by Kirill Faifer on 25.03.2025.
//

import XCTest
import CoreData
@testable import CookBook

final class RecipeCreationTests: XCTestCase {
    
    private var context: NSManagedObjectContext!
    private var model: RecipeCreationCoreDataModel!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        context = CoreDataStack.shared.newBackgroundContext
        model = RecipeCreationCoreDataModel()
    }

    override func tearDownWithError() throws {
        model = nil
        context = nil
    }
    
    // MARK: - Tests
    
    func testCookStepCreation() throws {
        let title = "first step"
        let step = model.nextCookStep()
        
        XCTAssert(step.number == 1, "step number is wrong")
    }
    
    func testMultipleCookStepCreation() throws {
        let title = "step"
        
        let step = model.nextCookStep()
        step.title = title
        
        model.recipe.addToInstruction(step)
        
        XCTAssert(step.number == 1, "first step number is wrong")
        
        let nextStep = model.nextCookStep()
        nextStep.title = title
        
        model.recipe.addToInstruction(nextStep)
        
        XCTAssert(nextStep.number == 2, "second step number is wrong")
    }
    
    func testSaveRecipe() throws {
        let recipeTitle = "Second recipe"
        
        let stepTitle = "First step"
        
        let ingredient = Ingredient(context: context)
        ingredient.name = "egg"
        ingredient.category = .dairy
        ingredient.form = .piece
        
        let step = model.nextCookStep()
        step.title = stepTitle
        
        model.recipe.title = recipeTitle
        model.recipe.addToIngredients(ingredient)
        model.recipe.addToInstruction(step)
        
        let mainContext = CoreDataStack.shared.mainContext
        let recipesBefore = try mainContext.fetch(Recipe.fetchRequest()).count
        try model.saveRecipe()
        let recipesAfter = try mainContext.fetch(Recipe.fetchRequest()).count
        
        XCTAssert(recipesBefore + 1 == recipesAfter, "recipe didn't save")
    }

}
