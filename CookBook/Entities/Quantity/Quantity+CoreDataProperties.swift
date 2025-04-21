//
//  Quantity+CoreDataProperties.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.04.2025.
//
//

import Foundation
import CoreData


extension Quantity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quantity> {
        NSFetchRequest<Quantity>(entityName: "Quantity")
    }

    @NSManaged public var amount: Double
    @NSManaged public var unitSymbol: String?
    
    public var unit: Dimension? {
        get {
            guard let unitSymbol else { return nil }
            return Dimension(symbol: unitSymbol)
        } set {
            unitSymbol = newValue?.symbol
        }
    }

}

extension Quantity : Identifiable {

}
