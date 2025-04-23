//
//  JSONDecoder+Init.swift
//  CookBook
//
//  Created by Kirill Faifer on 23.04.2025.
//

import CoreData

extension JSONDecoder {
    
    convenience init(context: NSManagedObjectContext) {
        self.init()
        userInfo = [.context: context]
    }
    
}
