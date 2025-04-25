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
public final class Quantity: NSManagedObject, Codable {
    
    static let entityName = "Quantity"

    private enum CodingKeys: String, CodingKey {
        case amount, unitSymbol
    }
    
}

// MARK: - Decodable

extension Quantity {
    
    public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Missing Core Data context"
            ))
        }
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        amount = try container.decode(Double.self, forKey: .amount)
        unitSymbol = try container.decode(String.self, forKey: .unitSymbol)
    }
    
}

// MARK: - Encodable

extension Quantity {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(amount, forKey: .amount)
        try container.encode(unitSymbol, forKey: .unitSymbol)
    }
    
}
