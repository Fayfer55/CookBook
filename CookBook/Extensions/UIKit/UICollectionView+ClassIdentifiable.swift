//
//  UICollectionView+ClassIdentifiable.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit.UICollectionView

extension UICollectionView {

    func register<T: UICollectionViewCell>(cellType: T.Type) where T: ClassIdentifiable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withCellType type: T.Type = T.self, for indexPath: IndexPath) -> T where T: ClassIdentifiable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? T
        else { fatalError(dequeueError(reuseId: type.reuseId)) }

        return cell
    }
    
    func cellForItem<T: UICollectionViewCell>(withCellType type: T.Type = T.self, at indexPath: IndexPath) -> T where T: ClassIdentifiable {
        guard let cell = cellForItem(at: indexPath) as? T
        else { fatalError(dequeueError(reuseId: type.reuseId)) }
        return cell
    }

}

// MARK: - Dequeue Error Method

extension UICollectionView {

    private func dequeueError(reuseId: String) -> String {
        return "Couldn't dequeue cell with identifier \(reuseId)"
    }

}
