//
//  Ingredient+CoreDataClass.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//
//

import Foundation
import CoreData

@objc(Ingredient)
public class Ingredient: NSManagedObject, Codable {

    private enum CodingKeys: String, CodingKey {
        case name, category, form, quantity
    }
    
    private enum Constants {
        static let entityName = "Ingredient"
    }
    
    // MARK: - Decoder

    public required init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Missing Core Data context"
            ))
        }
        guard let entity = NSEntityDescription.entity(forEntityName: Ingredient.Constants.entityName, in: context) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Can't create Ingredient Entity from Core Data context"
            ))
        }
        super.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(IngredientCategory.self, forKey: .category)
        form = try container.decode(IngredientForm.self, forKey: .form)
        quantity = try container.decode(Quantity.self, forKey: .quantity)
    }
    
    // MARK: - Encoder

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(form, forKey: .form)
        try container.encode(quantity, forKey: .quantity)
    }
    
}
