//
//  RecipeCreationView.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//

import SwiftUI

struct RecipeCreationView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var recipe: Recipe!
    
    // MARK: - Layout
    
    var body: some View {
        ScrollView {
            Button {
                
            } label: {
                Text("Ingredients")
            }
            
            Button {
                recipe.title = "My first recipe"
                
//                let ingredient = Ingredient(context: context)
//                ingredient.name = "Flour"
//                recipe.addToIngredients(ingredient)
                
                do {
                    try context.save()
                } catch {
                    print("object context saving failed with error – \(error)")
                }
            } label: {
                Text("Create")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            recipe = Recipe(context: context)
        }
    }
    
}

#Preview {
    let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    
    RecipeCreationView()
        .environment(\.managedObjectContext, context)
}
