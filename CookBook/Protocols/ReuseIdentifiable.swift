//
//  ReuseIdentifiable.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension ReuseIdentifiable {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
}
