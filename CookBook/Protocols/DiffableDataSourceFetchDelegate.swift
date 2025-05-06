//
//  DiffableDataSourceFetchDelegate.swift
//  CookBook
//
//  Created by Kirill Faifer on 06.05.2025.
//

import UIKit.NSDiffableDataSourceSectionSnapshot

/// This is a protocol for any Model that want to fetch some data for storing it in NSDiffableDataSourceSnapshot.
/// You can use it with Model that uses NSFetchedResultsController or with custom snapshot providing implementation
protocol DiffableDataSourceFetchDelegate<SectionIdentifierType, ItemIdentifierType>: AnyObject {
    associatedtype SectionIdentifierType: Hashable, Sendable
    associatedtype ItemIdentifierType: Hashable, Sendable
    
    func dataSource(didChangeWith snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>)
}
