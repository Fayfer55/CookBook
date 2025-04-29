//
//  Ingredient+CoreDataProperties.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//
//

import Foundation
import CoreData

extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        NSFetchRequest<Ingredient>(entityName: Ingredient.entityName)
    }

    @NSManaged public var categoryRaw: String
    @NSManaged public var formRaw: String
    @NSManaged public var name: String
    @NSManaged public var quantity: Quantity?
    
    public var form: IngredientForm {
        get {
            IngredientForm(rawValue: formRaw) ?? .piece
        } set {
            formRaw = newValue.rawValue
        }
    }
    
    public var category: IngredientCategory {
        get {
            IngredientCategory(rawValue: categoryRaw) ?? .fruits
        } set {
            categoryRaw = newValue.rawValue
        }
    }

}

extension Ingredient: Identifiable {

}
