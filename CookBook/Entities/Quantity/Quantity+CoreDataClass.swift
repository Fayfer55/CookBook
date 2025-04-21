//
//  Quantity+CoreDataClass.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//
//

import Foundation
import CoreData

@objc(Quantity)
public class Quantity: NSManagedObject, Codable {

    private enum CodingKeys: String, CodingKey {
        case amount, unitSymbol
    }
    
    private enum Constants {
        static let entityName = "Quantity"
    }

    // MARK: - Decodable
    
    public required init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Missing Core Data context"
            ))
        }
        guard let entity = NSEntityDescription.entity(forEntityName: Quantity.Constants.entityName, in: context) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Can't create Quantity Entity from Core Data context"
            ))
        }
        super.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        amount = try container.decode(Double.self, forKey: .amount)
        unitSymbol = try container.decode(String.self, forKey: .unitSymbol)
    }

    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(amount, forKey: .amount)
        try container.encode(unitSymbol, forKey: .unitSymbol)
    }
    
}
