//
//  CreateRecipeDataSource.swift
//  CookBook
//
//  Created by Kirill Faifer on 24.06.2025.
//

import Foundation
import UIKit.UICollectionViewCompositionalLayout

enum CreateRecipeSection: Int {
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
                    layoutSize: .fullWidth(forHeight: 40), subitems: [.init(layoutSize: .fullSize)]
                )
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
            case .cookSteps:
                break
        }
        return section
    }
}

enum CreateRecipeItem {
    case textField, button, label
}
