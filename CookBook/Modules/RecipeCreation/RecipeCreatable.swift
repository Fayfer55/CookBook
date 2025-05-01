//
//  RecipeCreatable.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.05.2025.
//

import Foundation

protocol RecipeCreatable {
    func addTitle(_ title: String)
    func addIngredients(_ ingredients: Set<Ingredient>)
    func addStep(title: String, subtitle: String?, tip: String?) -> CookStep
    func saveRecipe() throws
}
