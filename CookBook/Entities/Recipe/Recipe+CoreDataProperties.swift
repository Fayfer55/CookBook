//
//  Recipe+CoreDataProperties.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.04.2025.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var subtitle: String?
    @NSManaged public var title: String
    @NSManaged public var ingredients: NSSet
    @NSManaged public var instruction: NSOrderedSet

}

// MARK: Generated accessors for ingredients
extension Recipe {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for instruction
extension Recipe {

    @objc(insertObject:inInstructionAtIndex:)
    @NSManaged public func insertIntoInstruction(_ value: CookStep, at idx: Int)

    @objc(removeObjectFromInstructionAtIndex:)
    @NSManaged public func removeFromInstruction(at idx: Int)

    @objc(insertInstruction:atIndexes:)
    @NSManaged public func insertIntoInstruction(_ values: [CookStep], at indexes: NSIndexSet)

    @objc(removeInstructionAtIndexes:)
    @NSManaged public func removeFromInstruction(at indexes: NSIndexSet)

    @objc(replaceObjectInInstructionAtIndex:withObject:)
    @NSManaged public func replaceInstruction(at idx: Int, with value: CookStep)

    @objc(replaceInstructionAtIndexes:withInstruction:)
    @NSManaged public func replaceInstruction(at indexes: NSIndexSet, with values: [CookStep])

    @objc(addInstructionObject:)
    @NSManaged public func addToInstruction(_ value: CookStep)

    @objc(removeInstructionObject:)
    @NSManaged public func removeFromInstruction(_ value: CookStep)

    @objc(addInstruction:)
    @NSManaged public func addToInstruction(_ values: NSOrderedSet)

    @objc(removeInstruction:)
    @NSManaged public func removeFromInstruction(_ values: NSOrderedSet)

}

extension Recipe : Identifiable {

}
