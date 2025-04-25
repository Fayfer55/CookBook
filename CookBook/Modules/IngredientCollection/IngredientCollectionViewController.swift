//
//  IngredientCollectionViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class IngredientCollectionViewController: UICollectionViewController {
    
    let ingredients: Set<Ingredient>
    
    // MARK: - Lifecycle
    
    init(ingredients: Set<Ingredient>) {
        self.ingredients = ingredients
        let layout = UICollectionViewLayout()
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupParentView()
    }
    
    // MARK: - Layout

    private func setupParentView() {
        collectionView.register(cellType: IngredientCollectionCell.self)
    }

}

// MARK: UICollectionViewDataSource

extension IngredientCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { ingredients.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: IngredientCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        let orderedIngredients = ingredients.sorted { $0.name > $1.name }
        cell.configure(with: orderedIngredients[indexPath.item])
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension IngredientCollectionViewController {
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}
