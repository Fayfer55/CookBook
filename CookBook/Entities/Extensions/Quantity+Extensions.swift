//
//  Quantity+Extensions.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//

import Foundation

extension Quantity {
    
    public var unit: Dimension? {
        get {
            guard let unitSymbol else { return nil }
            return Dimension(symbol: unitSymbol)
        } set {
            unitSymbol = newValue?.symbol
        }
    }
    
}
