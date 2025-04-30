//
//  CookStep+CoreDataProperties.swift
//  CookBook
//
//  Created by Kirill Faifer on 30.04.2025.
//
//

import Foundation
import CoreData

extension CookStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CookStep> {
        return NSFetchRequest<CookStep>(entityName: "CookStep")
    }

    @NSManaged public var duration: Int16
    @NSManaged public var number: Int16
    @NSManaged public var subtitle: String?
    @NSManaged public var tip: String?
    @NSManaged public var title: String
    @NSManaged public var recipe: Recipe?

}

extension CookStep: Identifiable { }
