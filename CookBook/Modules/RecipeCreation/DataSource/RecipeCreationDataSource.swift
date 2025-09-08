//
//  CreateRecipeDataSource.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.06.2025.
//

import Foundation

enum RecipeCreationSection: Int, CaseIterable {
    case metaData, ingredients, cookSteps
    
    var headerTitle: String {
        switch self {
            case .metaData:
                return "Meta data"
            case .ingredients:
                return "Ingredients"
            case .cookSteps:
                return "Cook steps"
        }
    }
}

enum RecipeCreationRow: Hashable {
    case name, ingredient(UUID), cookStep(UUID)
}
