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

    func testAddTitle() throws {
        let title = "First recipe"
        
        model.addTitle(title)
        
        XCTAssert(model.recipe.title == title, "title in recipe is wrong")
    }
    
    func testAddIngredients() throws {
        let ingredient = Ingredient(context: context)
        ingredient.name = "tomato"
        ingredient.form = .piece
        ingredient.category = .vegetables
        
        let ingredients = Set([ingredient])
        model.addIngredients(ingredients)
        
        XCTAssert(model.recipe.ingredients.count == ingredients.count, "ingredients didn't set")
    }
    
    func testCookStepCreation() throws {
        let title = "first step"
        let subtitle = "subtitle of step"
        
        let step = model.addStep(title: title, subtitle: subtitle, tip: nil)
        
        XCTAssert(step.title == title, "title in step is wrong")
        XCTAssert(step.subtitle == subtitle, "subtitle in step is wrong")
        XCTAssertNil(step.tip, "tip in step is wrong")
    }
    
    func testAddCookStep() throws {
        let title = "first step"
        let subtitle = "subtitle of step"
        let tip = "this is a little tip"
        
        model.addStep(title: title, subtitle: subtitle, tip: tip)
        
        XCTAssert(model.recipe.instruction.count == 1, "step didn't set")
    }
    
    func testSaveRecipe() throws {
        let recipeTitle = "Second recipe"
        
        let stepTitle = "First step"
        let stepSubtitle = "First step subtitle"
        
        let ingredient = Ingredient(context: context)
        ingredient.name = "egg"
        ingredient.category = .dairy
        ingredient.form = .piece
        
        model.addTitle(recipeTitle)
        model.addIngredients(Set([ingredient]))
        model.addStep(title: stepTitle, subtitle: stepSubtitle, tip: nil)
        
        let mainContext = CoreDataStack.shared.mainContext
        let recipesBefore = try mainContext.fetch(Recipe.fetchRequest()).count
        try model.saveRecipe()
        let recipesAfter = try mainContext.fetch(Recipe.fetchRequest()).count
        
        XCTAssert(recipesBefore + 1 == recipesAfter, "recipe didn't save")
    }

}
