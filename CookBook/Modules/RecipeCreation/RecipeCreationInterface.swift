//
//  RecipeCreationInterface.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.05.2025.
//

import Foundation

protocol RecipeCreationInterface {
    var recipe: Recipe { get }
    
    func allIngredients() -> [Ingredient]
    func nextCookStep() -> CookStep
    func saveRecipe() throws
}
