//
//  ClassIdentifiable.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import Foundation

protocol ClassIdentifiable {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
}
