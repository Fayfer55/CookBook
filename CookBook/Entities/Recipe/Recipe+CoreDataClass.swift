//
//  Recipe+CoreDataClass.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.04.2025.
//
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.id = UUID()
    }

}
