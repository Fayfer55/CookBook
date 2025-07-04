//
//  CreateRecipeDataSource.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.06.2025.
//

import Foundation
import UIKit.UICollectionViewCompositionalLayout
import CoreData.NSManagedObjectID

enum RecipeCreationSection: Int {
    case name, ingredients, cookSteps
    
    @MainActor
    var layoutSection: NSCollectionLayoutSection {
        let group: NSCollectionLayoutGroup
        switch self {
            case .name:
                group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .fullWidth(forHeight: 50), subitems: [.init(layoutSize: .fullSize)]
                )
            case .ingredients:
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .estimated(100),
                        heightDimension: .estimated(50)
                    ),
                    subitems: [.init(layoutSize: .init(
                        widthDimension: .estimated(100),
                        heightDimension: .estimated(50)
                    ))]
                )
                group.edgeSpacing = .init(leading: .none, top: .fixed(8), trailing: .none, bottom: .fixed(8))
            case .cookSteps:
                group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .fullWidth(forHeight: 100), subitems: [.init(layoutSize: .fullSize)]
                )
        }
        let section = NSCollectionLayoutSection(group: group)
        section.supplementaryContentInsetsReference = .layoutMargins
        
        switch self {
            case .name:
                break
            case .ingredients:
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .fullWidth(forHeight: 25),
                        elementKind: "Header",
                        alignment: .topLeading
                    )
                ]
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 8
            case .cookSteps:
                break
        }
        return section
    }
}

enum RecipeCreationItem: Hashable {
    case textField, button(NSManagedObjectID), label
}
