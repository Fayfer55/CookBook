//
//  ManagedObjectModelTests.swift
//  CookBookTests
//
//  Created by Kirill Faifer on 06.05.2025.
//

import XCTest
import CoreData
@testable import CookBook

final class ManagedObjectModelTests: XCTestCase {
    
    private var context: NSManagedObjectContext!
    private var model: ManagedObjectModel<Recipe>!
    private var expectation: XCTestExpectation!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        context = CoreDataStack.shared.mainContext
        model = ManagedObjectModel<Recipe>()
        expectation = XCTestExpectation(description: "Background task completed")
        
        model.fetchedResultController.delegate = self
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        model = nil
        context = nil
        expectation = nil
        
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    
    func testFetchEmptyEntities() throws {
        try model.fetchRequest()
        wait(for: [expectation], timeout: 2)
        
        let fetchedObjects = try XCTUnwrap(model.fetchedResultController.fetchedObjects, "objects not fetched")
        XCTAssert(fetchedObjects.isEmpty, "objects contains something")
    }
    
    func testObjectForIndexPath() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        try createRecipe()
        
        try model.fetchRequest()
        
        XCTAssertNotNil(model.object(for: indexPath), "recipe doesn't exist")
    }
    
    func testDeleteObjectForIndexPath() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        try createRecipe()
        
        try model.fetchRequest()
        
        XCTAssert(model.fetchedResultController.fetchedObjects?.count == 1, "recipe didn't create")
        
        model.deleteObject(at: indexPath)
        
        wait(for: [expectation], timeout: 2)
        XCTAssert(model.fetchedResultController.fetchedObjects?.count == 0, "recipe didn't delete")
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

// MARK: - NSFetchedResultsControllerDelegate

extension ManagedObjectModelTests: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        guard snapshot.itemIdentifiers.count == .zero else { return }
        expectation.fulfill()
    }
    
}
