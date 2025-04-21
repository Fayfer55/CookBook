//
//  View+Environment.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import SwiftUI

extension View {
    
    func withManagedObjectContext() -> some View {
        self.environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
    
}
