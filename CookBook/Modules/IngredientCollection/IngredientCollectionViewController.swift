//
//  IngredientCollectionViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 25.04.2025.
//

import UIKit

final class IngredientCollectionViewController: GridViewController {
    
    let ingredients: [Ingredient]
    
    var selectedIngredients: [Ingredient] {
        guard let selectedIndexPaths = gridView.indexPathsForSelectedItems else { return [] }
        return selectedIndexPaths.map { ingredients[$0.item] }
    }
    
    // MARK: - Lifecycle
    
    init(ingredients: [Ingredient]) {
        self.ingredients = ingredients
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        super.init(layout: layout)
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
        gridView.register(cellType: IngredientCollectionCell.self)
        gridView.allowsMultipleSelection = true
    }

}

// MARK: UICollectionViewDataSource

extension IngredientCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { ingredients.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: IngredientCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: ingredients[indexPath.item])
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension IngredientCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = ingredients[indexPath.item].name
        let safeArea = NSDirectionalEdgeInsets.safeArea
        var size = title.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)])
        size.width += safeArea.leading + safeArea.trailing
        size.height += safeArea.top + safeArea.bottom
        return size
    }
    
}
