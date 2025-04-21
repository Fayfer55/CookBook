//
//  Ingredient+Extensions.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//

import Foundation

extension Ingredient {
    
    public var form: IngredientForm {
        get {
            IngredientForm(rawValue: formRaw ?? "piece") ?? .piece
        } set {
            formRaw = newValue.rawValue
        }
    }
    
    public var category: IngredientCategory {
        get {
            guard let raw = categoryRaw else { return .fruits }
            return IngredientCategory(rawValue: raw) ?? .fruits
        } set {
            categoryRaw = newValue.rawValue
        }
    }
    
}
