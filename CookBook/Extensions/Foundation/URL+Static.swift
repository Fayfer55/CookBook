//
//  URL+Static.swift
//  CookBook
//
//  Created by Kirill Faifer on 23.04.2025.
//

import Foundation

extension URL {
    
    static let ingredientsDirectory = Bundle.main.url(forResource: "Ingredients", withExtension: "txt")!
    
}
