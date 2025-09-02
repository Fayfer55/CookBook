//
//  IngredientsListViewController.swift
//  CookBook
//
//  Created by Kirill Faifer on 28.08.2025.
//

import UIKit

class IngredientsListViewController: UITableViewController {
    
    var textFieldDidChange: ((_ textField: UITextField) -> Void)?
    var textFieldDidReturn: ((_ textField: UITextField) -> Void)?
    
    private lazy var presenter = IngredientsListPresenter()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Int, Int>(tableView: tableView) { [unowned self] tableView, indexPath, _ in
        let cell: ButtonedTextFieldListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textField.placeholder = "New item"
        cell.textField.delegate = self
        cell.textField.autocorrectionType = .no
        cell.textField.tag = indexPath.row
        cell.textField.returnKeyType = .next
        cell.textField.addTarget(self, action: #selector(textFieldDidChangeEditing), for: .editingChanged)
        return cell
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellType: ButtonedTextFieldListCell.self)
        setupInitialDataSourceSnapshot()
    }
    
    // MARK: - Setup DataSource
    
    private func setupInitialDataSourceSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([.zero])
        snapshot.appendItems([.zero], toSection: .zero)
        dataSource.apply(snapshot)
    }
    
    // MARK: - Actions
    
    @objc
    private func textFieldDidChangeEditing(_ textField: UITextField) {
        textFieldDidChange?(textField)
    }
    
    // MARK: - Helpers
    
    func addIngredient(_ ingredient: Ingredient, place: Int) {
        if presenter.ingredients.indices.contains(place) {
            presenter.ingredients[place] = ingredient
        } else {
            presenter.ingredients.append(ingredient)
        }
    }
    
    func makeNextRowFirstResponder(currentRow: Int) {
        let itemsCount = tableView.numberOfRows(inSection: .zero)
        
        if currentRow == itemsCount - 1 {
            createNextRow()
        }
        
        let cell: ButtonedTextFieldListCell = tableView.cellForRow(at: IndexPath(row: currentRow + 1, section: .zero))
        cell.textField.becomeFirstResponder()
    }
    
    private func createNextRow() {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([snapshot.numberOfItems(inSection: .zero)], toSection: .zero)
        dataSource.apply(snapshot)
    }

}

// MARK: - UITextFieldDelegate

extension IngredientsListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldDidReturn?(textField)
        return true
    }
    
}
