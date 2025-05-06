//
//  DataFetchable.swift
//  CookBook
//
//  Created by Kirill Faifer on 02.05.2025.
//

import UIKit

/// This is protocol for fetching array of Items. It uses NSDiffableDataSource as an abstraction layer of storing.
/// It allows to combine CoreData's NSFetchedResultsControllerDelegate & some mock's type to show in UITableViewController
protocol DataFetchable<SectionIdentifierType, ItemIdentifierType>: AnyObject {
    associatedtype SectionIdentifierType: Hashable, Sendable
    associatedtype ItemIdentifierType: Hashable, Sendable
    
    var delegate: (any DiffableDataSourceFetchDelegate<SectionIdentifierType, ItemIdentifierType>)? { get set }
    func fetchRequest()
}
