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
                return .empty
            case .ingredients:
                return RecipeCreationViewController.Localizables.ingredientsHeaderTitle
            case .cookSteps:
                return RecipeCreationViewController.Localizables.cookStepsHeaderTitle
        }
    }
}

enum RecipeCreationRow: Hashable {
    case name, ingredient(UUID), cookStep(UUID)
}
