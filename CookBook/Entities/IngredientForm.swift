//
//  IngredientForm.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//

import Foundation

public enum IngredientForm: String, Codable {
    case mass   // Covers grams, kilograms, ounces, etc.
    case volume // Covers milliliters, teaspoons, cups, etc.
    case piece  // Covers countable items like eggs, tomatoes, etc.
    
    var unit: Unit.Type? {
        switch self {
            case .mass:
                UnitMass.self
            case .volume:
                UnitVolume.self
            case .piece:
                nil
        }
    }
}
