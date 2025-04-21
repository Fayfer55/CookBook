//
//  RecipeListView.swift
//  CookBook
//
//  Created by Kirill Faifer on 20.04.2025.
//

import SwiftUI

struct RecipeListView: ViewNavigatable {
    
    let navigationController: UINavigationController
    
    @FetchRequest(sortDescriptors: []) private var recipes: FetchedResults<Recipe>
    
    // MARK: - Layout
    
    var body: some View {
        if recipes.isEmpty {
            VStack {
                Button {
                    
                } label: {
                    Text("Create my first recipe")
                        .font(.title3)
                        .clipShape(.capsule)
                }
            }
        } else {
            List(recipes) { recipe in
                let title = recipe.title ?? "no title"
                Text(title)
            }
        }
    }
    
}

#Preview {
    RecipeListView(navigationController: UINavigationController())
}
