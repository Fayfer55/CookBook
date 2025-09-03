//
//  CreateRecipeDataSource.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.06.2025.
//

import Foundation

enum RecipeCreationSection: Int {
    case metaData, ingredients, cookSteps
}

enum RecipeCreationRow: Hashable {
    case textField
}
