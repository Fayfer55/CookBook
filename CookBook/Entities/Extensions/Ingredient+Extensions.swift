//
//  Ingredient+Extensions.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//

import Foundation

extension Ingredient {
    
    public var unit: IngredientUnit {
        get {
            IngredientUnit(rawValue: unitRaw ?? "piece") ?? .piece
        } set {
            unitRaw = newValue.rawValue
        }
    }
    
    public var countableSize: CountableSize? {
        get {
            guard let raw = countableSizeRaw else { return nil }
            return CountableSize(rawValue: raw)
        } set {
            countableSizeRaw = newValue?.rawValue
        }
    }
    
}
