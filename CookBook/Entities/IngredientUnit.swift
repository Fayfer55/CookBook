//
//  IngredientUnit.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//

import Foundation

public enum IngredientUnit: String, Codable {
    case gram
    case teaspoon
    case tablespoon
    case cup
    case piece  // For countable ingredients like "1 tomato"
}
