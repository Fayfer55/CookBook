//
//  RecipeFetchingTests.swift
//  CookBookTests
//
//  Created by Kirill Faifer on 06.05.2025.
//

import XCTest
import CoreData
@testable import CookBook

final class RecipeFetchingTests: XCTestCase {
    
    private var context: NSManagedObjectContext!
    private var model: RecipeListCoreDataModel!
    private var expectation: XCTestExpectation!
    private var snapshot: NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>?
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        context = CoreDataStack.shared.mainContext
        model = RecipeListCoreDataModel(context: context)
        expectation = XCTestExpectation(description: "Background task completes")
        model.delegate = self
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        model = nil
        context = nil
        expectation = nil
        snapshot = nil
        
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    
    func testFetchEmptyEntities() throws {
        try model.fetchRequest()
        wait(for: [expectation], timeout: 2)
        
        let fetchedObjects = try XCTUnwrap(model.fetchedResultController.fetchedObjects, "objects not fetched")
        XCTAssert(fetchedObjects.isEmpty, "objects contains something")
    }
    
    func testEmptySnapshot() throws {
        try model.fetchRequest()
        
        wait(for: [expectation], timeout: 2)
        
        let snapshot = try XCTUnwrap(snapshot, "Snapshot is nil")
        XCTAssert(snapshot.itemIdentifiers.isEmpty, "items exists")
    }
    
    func testOneItemSnapshot() throws {
        try model.fetchRequest()
        
        wait(for: [expectation], timeout: 2)
        
        let firstSnapshot = try XCTUnwrap(snapshot, "Snapshot is nil")
        XCTAssert(firstSnapshot.itemIdentifiers.isEmpty, "items exists")
        
        try createRecipe()
        
        let secondSnapshot = try XCTUnwrap(snapshot, "Snapshot is nil")
        XCTAssert(secondSnapshot.itemIdentifiers.count == 1, "items count is wrong")
    }
    
    // MARK: - Private Helpers
    
    private func createRecipe() throws {
        let recipe = Recipe(context: context)
        recipe.title = "Second recipe"
        
        let step = CookStep(context: context)
        step.number = 1
        step.title = "First step"
        
        let ingredient = Ingredient(context: context)
        ingredient.name = "egg"
        ingredient.category = .dairy
        ingredient.form = .piece
        
        recipe.addToIngredients(ingredient)
        recipe.addToInstruction(step)
        
        try context.save()
    }

}

// MARK: - DiffableDataSourceFetchDelegate

extension RecipeFetchingTests: DiffableDataSourceFetchDelegate {
    
    func dataSource(didChangeWith snapshot: NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>) {
        self.snapshot = snapshot
        expectation.fulfill()
    }
    
}
