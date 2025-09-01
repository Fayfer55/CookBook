//
//  RecipeCreationPresenter.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.07.2025.
//

import Foundation

struct RecipeCreationPresenter {
    
    unowned let view: RecipeCreationViewController
    
    let storage = CoreDataContextStorageObject(type: .privateQueue, label: "coreData.contextStorage.RecipeCreation.queue")
    
}
